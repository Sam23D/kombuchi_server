defmodule KombuchiServer.FrontendFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KombuchiServer.Frontend` context.
  """

  @doc """
  Generate a subscribe.
  """
  def subscribe_fixture(attrs \\ %{}) do
    {:ok, subscribe} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name"
      })
      |> KombuchiServer.Frontend.create_subscribe()

    subscribe
  end

  @doc """
  Generate a seller.
  """
  def seller_fixture(attrs \\ %{}) do
    {:ok, seller} =
      attrs
      |> Enum.into(%{
        description: "some description",
        logo: "some logo",
        name: "some name",
        sitelink: "some sitelink",
        website: "some website"
      })
      |> KombuchiServer.Frontend.create_seller()

    seller
  end
end
