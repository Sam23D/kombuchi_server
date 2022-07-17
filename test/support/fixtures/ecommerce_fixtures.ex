defmodule KombuchiServer.EcommerceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KombuchiServer.Ecommerce` context.
  """

  @doc """
  Generate a sell_item.
  """
  def sell_item_fixture(attrs \\ %{}) do
    {:ok, sell_item} =
      attrs
      |> Enum.into(%{
        escription: "some escription",
        name: "some name"
      })
      |> KombuchiServer.Ecommerce.create_sell_item()

    sell_item
  end
end
