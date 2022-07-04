defmodule KombuchiServer.Frontend.Subscribe do
  use Ecto.Schema
  import Ecto.Changeset
  alias KombuchiServer.Accounts.User

  schema "subscribers" do
    field :age, :integer
    field :email, :string, unique: true
    field :name, :string
    belongs_to :user, User

    #TBD refactor to have
    # :type, "email,. phone, sms, etc..."
    # :value, email or phone or custom....
    timestamps()
  end

  @doc false
  def changeset(subscribe, attrs) do
    subscribe
    |> cast(attrs, [:name, :age, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/(.*?)\@\w+\.\w+/)
    |> unique_constraint(:unique_email, name: :subscribers_email_index)
    # validate uniqueness
    # make email unique on DB and indexed
  end
end
