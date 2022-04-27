defmodule KombuchiServer.Repo.Migrations.SubscribeBelongsToUser do
  use Ecto.Migration
  alias KombuchiServer.Accounts.User


  def change do

    # alter users make email indexed
    alter table(:subscribers)do
      add :user_id, references(:users)
    end

    create unique_index(:subscribers, [:email])
  end
end
