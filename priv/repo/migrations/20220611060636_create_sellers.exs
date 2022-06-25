defmodule KombuchiServer.Repo.Migrations.CreateSellers do
  use Ecto.Migration

  def change do
    create table(:sellers) do
      add :name, :string
      add :logo, :string
      add :website, :string
      add :sitelink, :string
      add :description, :string

      timestamps()
    end
  end
end
