defmodule KombuchiServer.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :name, :string
      add :age, :integer
      add :email, :string

      timestamps()
    end
  end
end
