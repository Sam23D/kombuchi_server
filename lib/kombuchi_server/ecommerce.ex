defmodule KombuchiServer.Ecommerce do
  @moduledoc """
  The Ecommerce context.
  """

  import Ecto.Query, warn: false
  alias KombuchiServer.Repo

  alias KombuchiServer.Ecommerce.SellItem

  @doc """
  Returns the list of sell_items.

  ## Examples

      iex> list_sell_items()
      [%SellItem{}, ...]

  """
  def list_sell_items do
    Repo.all(SellItem)
  end

  @doc """
  Gets a single sell_item.

  Raises `Ecto.NoResultsError` if the Sell item does not exist.

  ## Examples

      iex> get_sell_item!(123)
      %SellItem{}

      iex> get_sell_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sell_item!(id), do: Repo.get!(SellItem, id)

  @doc """
  Creates a sell_item.

  ## Examples

      iex> create_sell_item(%{field: value})
      {:ok, %SellItem{}}

      iex> create_sell_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sell_item(attrs \\ %{}) do
    %SellItem{}
    |> SellItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sell_item.

  ## Examples

      iex> update_sell_item(sell_item, %{field: new_value})
      {:ok, %SellItem{}}

      iex> update_sell_item(sell_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sell_item(%SellItem{} = sell_item, attrs) do
    sell_item
    |> SellItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sell_item.

  ## Examples

      iex> delete_sell_item(sell_item)
      {:ok, %SellItem{}}

      iex> delete_sell_item(sell_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sell_item(%SellItem{} = sell_item) do
    Repo.delete(sell_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sell_item changes.

  ## Examples

      iex> change_sell_item(sell_item)
      %Ecto.Changeset{data: %SellItem{}}

  """
  def change_sell_item(%SellItem{} = sell_item, attrs \\ %{}) do
    SellItem.changeset(sell_item, attrs)
  end
end
