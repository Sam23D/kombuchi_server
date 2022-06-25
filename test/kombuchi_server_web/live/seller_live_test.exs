defmodule KombuchiServerWeb.SellerLiveTest do
  use KombuchiServerWeb.ConnCase

  import Phoenix.LiveViewTest
  import KombuchiServer.FrontendFixtures

  @create_attrs %{description: "some description", logo: "some logo", name: "some name", sitelink: "some sitelink", website: "some website"}
  @update_attrs %{description: "some updated description", logo: "some updated logo", name: "some updated name", sitelink: "some updated sitelink", website: "some updated website"}
  @invalid_attrs %{description: nil, logo: nil, name: nil, sitelink: nil, website: nil}

  defp create_seller(_) do
    seller = seller_fixture()
    %{seller: seller}
  end

  describe "Index" do
    setup [:create_seller]

    test "lists all sellers", %{conn: conn, seller: seller} do
      {:ok, _index_live, html} = live(conn, Routes.seller_index_path(conn, :index))

      assert html =~ "Listing Sellers"
      assert html =~ seller.description
    end

    test "saves new seller", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.seller_index_path(conn, :index))

      assert index_live |> element("a", "New Seller") |> render_click() =~
               "New Seller"

      assert_patch(index_live, Routes.seller_index_path(conn, :new))

      assert index_live
             |> form("#seller-form", seller: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#seller-form", seller: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.seller_index_path(conn, :index))

      assert html =~ "Seller created successfully"
      assert html =~ "some description"
    end

    test "updates seller in listing", %{conn: conn, seller: seller} do
      {:ok, index_live, _html} = live(conn, Routes.seller_index_path(conn, :index))

      assert index_live |> element("#seller-#{seller.id} a", "Edit") |> render_click() =~
               "Edit Seller"

      assert_patch(index_live, Routes.seller_index_path(conn, :edit, seller))

      assert index_live
             |> form("#seller-form", seller: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#seller-form", seller: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.seller_index_path(conn, :index))

      assert html =~ "Seller updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes seller in listing", %{conn: conn, seller: seller} do
      {:ok, index_live, _html} = live(conn, Routes.seller_index_path(conn, :index))

      assert index_live |> element("#seller-#{seller.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#seller-#{seller.id}")
    end
  end

  describe "Show" do
    setup [:create_seller]

    test "displays seller", %{conn: conn, seller: seller} do
      {:ok, _show_live, html} = live(conn, Routes.seller_show_path(conn, :show, seller))

      assert html =~ "Show Seller"
      assert html =~ seller.description
    end

    test "updates seller within modal", %{conn: conn, seller: seller} do
      {:ok, show_live, _html} = live(conn, Routes.seller_show_path(conn, :show, seller))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Seller"

      assert_patch(show_live, Routes.seller_show_path(conn, :edit, seller))

      assert show_live
             |> form("#seller-form", seller: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#seller-form", seller: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.seller_show_path(conn, :show, seller))

      assert html =~ "Seller updated successfully"
      assert html =~ "some updated description"
    end
  end
end
