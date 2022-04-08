defmodule KombuchiServer.Repo do
  use Ecto.Repo,
    otp_app: :kombuchi_server,
    adapter: Ecto.Adapters.Postgres
end
