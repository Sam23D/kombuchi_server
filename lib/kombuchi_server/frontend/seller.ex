defmodule KombuchiServer.Frontend.Seller do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sellers" do
    field :description, :string
    field :logo, :string
    field :name, :string
    field :sitelink, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(seller, attrs) do
    seller
    |> cast(attrs, [:name, :logo, :website, :sitelink, :description])
    |> validate_required([:name, :logo, :website, :sitelink, :description])
  end
end
