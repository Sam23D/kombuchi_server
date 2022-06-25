defmodule KombuchiServer.FrontendTest do
  use KombuchiServer.DataCase

  alias KombuchiServer.Frontend

  describe "subscribers" do
    alias KombuchiServer.Frontend.Subscribe

    import KombuchiServer.FrontendFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil}

    test "list_subscribers/0 returns all subscribers" do
      subscribe = subscribe_fixture()
      assert Frontend.list_subscribers() == [subscribe]
    end

    test "get_subscribe!/1 returns the subscribe with given id" do
      subscribe = subscribe_fixture()
      assert Frontend.get_subscribe!(subscribe.id) == subscribe
    end

    test "create_subscribe/1 with valid data creates a subscribe" do
      valid_attrs = %{age: 42, email: "some email", name: "some name"}

      assert {:ok, %Subscribe{} = subscribe} = Frontend.create_subscribe(valid_attrs)
      assert subscribe.age == 42
      assert subscribe.email == "some email"
      assert subscribe.name == "some name"
    end

    test "create_subscribe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frontend.create_subscribe(@invalid_attrs)
    end

    test "update_subscribe/2 with valid data updates the subscribe" do
      subscribe = subscribe_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name"}

      assert {:ok, %Subscribe{} = subscribe} = Frontend.update_subscribe(subscribe, update_attrs)
      assert subscribe.age == 43
      assert subscribe.email == "some updated email"
      assert subscribe.name == "some updated name"
    end

    test "update_subscribe/2 with invalid data returns error changeset" do
      subscribe = subscribe_fixture()
      assert {:error, %Ecto.Changeset{}} = Frontend.update_subscribe(subscribe, @invalid_attrs)
      assert subscribe == Frontend.get_subscribe!(subscribe.id)
    end

    test "delete_subscribe/1 deletes the subscribe" do
      subscribe = subscribe_fixture()
      assert {:ok, %Subscribe{}} = Frontend.delete_subscribe(subscribe)
      assert_raise Ecto.NoResultsError, fn -> Frontend.get_subscribe!(subscribe.id) end
    end

    test "change_subscribe/1 returns a subscribe changeset" do
      subscribe = subscribe_fixture()
      assert %Ecto.Changeset{} = Frontend.change_subscribe(subscribe)
    end
  end

  describe "sellers" do
    alias KombuchiServer.Frontend.Seller

    import KombuchiServer.FrontendFixtures

    @invalid_attrs %{description: nil, logo: nil, name: nil, sitelink: nil, website: nil}

    test "list_sellers/0 returns all sellers" do
      seller = seller_fixture()
      assert Frontend.list_sellers() == [seller]
    end

    test "get_seller!/1 returns the seller with given id" do
      seller = seller_fixture()
      assert Frontend.get_seller!(seller.id) == seller
    end

    test "create_seller/1 with valid data creates a seller" do
      valid_attrs = %{description: "some description", logo: "some logo", name: "some name", sitelink: "some sitelink", website: "some website"}

      assert {:ok, %Seller{} = seller} = Frontend.create_seller(valid_attrs)
      assert seller.description == "some description"
      assert seller.logo == "some logo"
      assert seller.name == "some name"
      assert seller.sitelink == "some sitelink"
      assert seller.website == "some website"
    end

    test "create_seller/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Frontend.create_seller(@invalid_attrs)
    end

    test "update_seller/2 with valid data updates the seller" do
      seller = seller_fixture()
      update_attrs = %{description: "some updated description", logo: "some updated logo", name: "some updated name", sitelink: "some updated sitelink", website: "some updated website"}

      assert {:ok, %Seller{} = seller} = Frontend.update_seller(seller, update_attrs)
      assert seller.description == "some updated description"
      assert seller.logo == "some updated logo"
      assert seller.name == "some updated name"
      assert seller.sitelink == "some updated sitelink"
      assert seller.website == "some updated website"
    end

    test "update_seller/2 with invalid data returns error changeset" do
      seller = seller_fixture()
      assert {:error, %Ecto.Changeset{}} = Frontend.update_seller(seller, @invalid_attrs)
      assert seller == Frontend.get_seller!(seller.id)
    end

    test "delete_seller/1 deletes the seller" do
      seller = seller_fixture()
      assert {:ok, %Seller{}} = Frontend.delete_seller(seller)
      assert_raise Ecto.NoResultsError, fn -> Frontend.get_seller!(seller.id) end
    end

    test "change_seller/1 returns a seller changeset" do
      seller = seller_fixture()
      assert %Ecto.Changeset{} = Frontend.change_seller(seller)
    end
  end
end
