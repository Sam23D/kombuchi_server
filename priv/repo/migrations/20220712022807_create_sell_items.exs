defmodule KombuchiServer.Repo.Migrations.CreateSellItems do
  use Ecto.Migration

  def change do
    create table(:sell_items) do
      add :name, :string
      add :escription, :string
      add :seller_id, references(:sellers, on_delete: :nothing)

      timestamps()
    end

    create index(:sell_items, [:seller_id])
  end
end
