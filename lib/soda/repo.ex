defmodule Soda.Repo do
  use Ecto.Repo,
    otp_app: :soda,
    adapter: Ecto.Adapters.Postgres
end
