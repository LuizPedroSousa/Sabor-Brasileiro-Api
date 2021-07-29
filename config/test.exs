use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :sabor_brasileiro, SaborBrasileiro.Repo,
  username: "postgres",
  password: "lp2316695436",
  database: "sabor_brasileiro_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "127.0.0.1",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sabor_brasileiro, SaborBrasileiroWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
