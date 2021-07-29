defmodule SaborBrasileiro.Repo do
  use Ecto.Repo,
    otp_app: :sabor_brasileiro,
    adapter: Ecto.Adapters.Postgres
end
