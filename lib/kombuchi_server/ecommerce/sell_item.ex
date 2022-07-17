defmodule KombuchiServer.Ecommerce.SellItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sell_items" do
    field :escription, :string
    field :name, :string
    field :seller_id, :id

    timestamps()
  end

  @doc false
  def changeset(sell_item, attrs) do
    sell_item
    |> cast(attrs, [:name, :escription])
    |> validate_required([:name, :escription])
  end
end
