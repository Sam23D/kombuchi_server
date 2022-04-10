defmodule KombuchiServer.Frontend.Subscribe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscribers" do
    field :age, :integer
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(subscribe, attrs) do
    subscribe
    |> cast(attrs, [:name, :age, :email])
    |> validate_required([:name, :age, :email])
  end
end
