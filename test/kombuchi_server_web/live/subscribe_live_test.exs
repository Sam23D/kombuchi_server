defmodule KombuchiServerWeb.SubscribeLiveTest do
  use KombuchiServerWeb.ConnCase

  import Phoenix.LiveViewTest
  import KombuchiServer.FrontendFixtures

  @create_attrs %{age: 42, email: "some email", name: "some name"}
  @update_attrs %{age: 43, email: "some updated email", name: "some updated name"}
  @invalid_attrs %{age: nil, email: nil, name: nil}

  defp create_subscribe(_) do
    subscribe = subscribe_fixture()
    %{subscribe: subscribe}
  end

  describe "Index" do
    setup [:create_subscribe]

    test "lists all subscribers", %{conn: conn, subscribe: subscribe} do
      {:ok, _index_live, html} = live(conn, Routes.subscribe_index_path(conn, :index))

      assert html =~ "Listing Subscribers"
      assert html =~ subscribe.email
    end

    test "saves new subscribe", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.subscribe_index_path(conn, :index))

      assert index_live |> element("a", "New Subscribe") |> render_click() =~
               "New Subscribe"

      assert_patch(index_live, Routes.subscribe_index_path(conn, :new))

      assert index_live
             |> form("#subscribe-form", subscribe: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#subscribe-form", subscribe: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.subscribe_index_path(conn, :index))

      assert html =~ "Subscribe created successfully"
      assert html =~ "some email"
    end

    test "updates subscribe in listing", %{conn: conn, subscribe: subscribe} do
      {:ok, index_live, _html} = live(conn, Routes.subscribe_index_path(conn, :index))

      assert index_live |> element("#subscribe-#{subscribe.id} a", "Edit") |> render_click() =~
               "Edit Subscribe"

      assert_patch(index_live, Routes.subscribe_index_path(conn, :edit, subscribe))

      assert index_live
             |> form("#subscribe-form", subscribe: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#subscribe-form", subscribe: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.subscribe_index_path(conn, :index))

      assert html =~ "Subscribe updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes subscribe in listing", %{conn: conn, subscribe: subscribe} do
      {:ok, index_live, _html} = live(conn, Routes.subscribe_index_path(conn, :index))

      assert index_live |> element("#subscribe-#{subscribe.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#subscribe-#{subscribe.id}")
    end
  end

  describe "Show" do
    setup [:create_subscribe]

    test "displays subscribe", %{conn: conn, subscribe: subscribe} do
      {:ok, _show_live, html} = live(conn, Routes.subscribe_show_path(conn, :show, subscribe))

      assert html =~ "Show Subscribe"
      assert html =~ subscribe.email
    end

    test "updates subscribe within modal", %{conn: conn, subscribe: subscribe} do
      {:ok, show_live, _html} = live(conn, Routes.subscribe_show_path(conn, :show, subscribe))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Subscribe"

      assert_patch(show_live, Routes.subscribe_show_path(conn, :edit, subscribe))

      assert show_live
             |> form("#subscribe-form", subscribe: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#subscribe-form", subscribe: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.subscribe_show_path(conn, :show, subscribe))

      assert html =~ "Subscribe updated successfully"
      assert html =~ "some updated email"
    end
  end
end
