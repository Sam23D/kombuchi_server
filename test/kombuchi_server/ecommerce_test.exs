defmodule KombuchiServer.EcommerceTest do
  use KombuchiServer.DataCase

  alias KombuchiServer.Ecommerce

  describe "sell_items" do
    alias KombuchiServer.Ecommerce.SellItem

    import KombuchiServer.EcommerceFixtures

    @invalid_attrs %{escription: nil, name: nil}

    test "list_sell_items/0 returns all sell_items" do
      sell_item = sell_item_fixture()
      assert Ecommerce.list_sell_items() == [sell_item]
    end

    test "get_sell_item!/1 returns the sell_item with given id" do
      sell_item = sell_item_fixture()
      assert Ecommerce.get_sell_item!(sell_item.id) == sell_item
    end

    test "create_sell_item/1 with valid data creates a sell_item" do
      valid_attrs = %{escription: "some escription", name: "some name"}

      assert {:ok, %SellItem{} = sell_item} = Ecommerce.create_sell_item(valid_attrs)
      assert sell_item.escription == "some escription"
      assert sell_item.name == "some name"
    end

    test "create_sell_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ecommerce.create_sell_item(@invalid_attrs)
    end

    test "update_sell_item/2 with valid data updates the sell_item" do
      sell_item = sell_item_fixture()
      update_attrs = %{escription: "some updated escription", name: "some updated name"}

      assert {:ok, %SellItem{} = sell_item} = Ecommerce.update_sell_item(sell_item, update_attrs)
      assert sell_item.escription == "some updated escription"
      assert sell_item.name == "some updated name"
    end

    test "update_sell_item/2 with invalid data returns error changeset" do
      sell_item = sell_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Ecommerce.update_sell_item(sell_item, @invalid_attrs)
      assert sell_item == Ecommerce.get_sell_item!(sell_item.id)
    end

    test "delete_sell_item/1 deletes the sell_item" do
      sell_item = sell_item_fixture()
      assert {:ok, %SellItem{}} = Ecommerce.delete_sell_item(sell_item)
      assert_raise Ecto.NoResultsError, fn -> Ecommerce.get_sell_item!(sell_item.id) end
    end

    test "change_sell_item/1 returns a sell_item changeset" do
      sell_item = sell_item_fixture()
      assert %Ecto.Changeset{} = Ecommerce.change_sell_item(sell_item)
    end
  end
end
