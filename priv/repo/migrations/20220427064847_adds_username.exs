defmodule KombuchiServer.Repo.Migrations.AddsUsername do
  use Ecto.Migration

  def change do
    alter table(:users)do
      add :name, :string, null: true
      add :lastname, :string, null: true
    end
  end
end
