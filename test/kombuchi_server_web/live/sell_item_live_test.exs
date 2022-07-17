defmodule KombuchiServerWeb.SellItemLiveTest do
  use KombuchiServerWeb.ConnCase

  import Phoenix.LiveViewTest
  import KombuchiServer.EcommerceFixtures

  @create_attrs %{escription: "some escription", name: "some name"}
  @update_attrs %{escription: "some updated escription", name: "some updated name"}
  @invalid_attrs %{escription: nil, name: nil}

  defp create_sell_item(_) do
    sell_item = sell_item_fixture()
    %{sell_item: sell_item}
  end

  describe "Index" do
    setup [:create_sell_item]

    test "lists all sell_items", %{conn: conn, sell_item: sell_item} do
      {:ok, _index_live, html} = live(conn, Routes.sell_item_index_path(conn, :index))

      assert html =~ "Listing Sell items"
      assert html =~ sell_item.escription
    end

    test "saves new sell_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.sell_item_index_path(conn, :index))

      assert index_live |> element("a", "New Sell item") |> render_click() =~
               "New Sell item"

      assert_patch(index_live, Routes.sell_item_index_path(conn, :new))

      assert index_live
             |> form("#sell_item-form", sell_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sell_item-form", sell_item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sell_item_index_path(conn, :index))

      assert html =~ "Sell item created successfully"
      assert html =~ "some escription"
    end

    test "updates sell_item in listing", %{conn: conn, sell_item: sell_item} do
      {:ok, index_live, _html} = live(conn, Routes.sell_item_index_path(conn, :index))

      assert index_live |> element("#sell_item-#{sell_item.id} a", "Edit") |> render_click() =~
               "Edit Sell item"

      assert_patch(index_live, Routes.sell_item_index_path(conn, :edit, sell_item))

      assert index_live
             |> form("#sell_item-form", sell_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sell_item-form", sell_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sell_item_index_path(conn, :index))

      assert html =~ "Sell item updated successfully"
      assert html =~ "some updated escription"
    end

    test "deletes sell_item in listing", %{conn: conn, sell_item: sell_item} do
      {:ok, index_live, _html} = live(conn, Routes.sell_item_index_path(conn, :index))

      assert index_live |> element("#sell_item-#{sell_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sell_item-#{sell_item.id}")
    end
  end

  describe "Show" do
    setup [:create_sell_item]

    test "displays sell_item", %{conn: conn, sell_item: sell_item} do
      {:ok, _show_live, html} = live(conn, Routes.sell_item_show_path(conn, :show, sell_item))

      assert html =~ "Show Sell item"
      assert html =~ sell_item.escription
    end

    test "updates sell_item within modal", %{conn: conn, sell_item: sell_item} do
      {:ok, show_live, _html} = live(conn, Routes.sell_item_show_path(conn, :show, sell_item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sell item"

      assert_patch(show_live, Routes.sell_item_show_path(conn, :edit, sell_item))

      assert show_live
             |> form("#sell_item-form", sell_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#sell_item-form", sell_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sell_item_show_path(conn, :show, sell_item))

      assert html =~ "Sell item updated successfully"
      assert html =~ "some updated escription"
    end
  end
end
