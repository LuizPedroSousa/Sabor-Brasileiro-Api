# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sabor_brasileiro,
  ecto_repos: [SaborBrasileiro.Repo]

config :sabor_brasileiro, SaborBrasileiro.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :sabor_brasileiro, SaborBrasileiroWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4X2tEEgW4KRhYzXkN3C7VyZF2Cc19f+/ICpzt9yod8AzyzJUa78oY2zwwkBOgsXC",
  render_errors: [view: SaborBrasileiroWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SaborBrasileiro.PubSub,
  live_view: [signing_salt: "xt8/LjZe"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
