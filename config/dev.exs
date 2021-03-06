use Mix.Config

# Configure your database
config :sabor_brasileiro, SaborBrasileiro.Repo,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: "sabor_brasileiro_dev",
  hostname: System.get_env("DB_HOST"),
  port: System.get_env("DB_PORT"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.

config :sabor_brasileiro, SaborBrasileiro.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SMTP_SERVER"),
  hostname: System.get_env("SMTP_HOSTNAME"),
  port: System.get_env("SMTP_PORT"),
  # or {:system, "SMTP_USERNAME"}
  username: System.get_env("SMTP_USERNAME"),
  # or {:system, "SMTP_PASSWORD"}
  password: System.get_env("SMTP_PASSWORD"),
  # can be `:always` or `:never`
  tls: :always,
  # or {:system, "ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  tls_log_level: :error,
  # optional, can be `:verify_peer` or `:verify_none`
  tls_verify: :verify_peer,
  # optional, path to the ca truststore
  tls_cacertfile: "/somewhere/on/disk",
  # optional, DER-encoded trusted certificates
  tls_cacerts: "…",
  # optional, tls certificate chain depth
  tls_depth: 3,
  # optional, tls verification function
  tls_verify_fun: {&:ssl_verify_hostname.verify_fun/3, check_hostname: "example.com"},
  # can be `true`
  ssl: false,
  retries: 1,
  # can be `true`
  no_mx_lookups: false,
  # can be `:always`. If your smtp relay requires authentication set it to `:always`.
  auth: :if_available

config :sabor_brasileiro, SaborBrasileiro.Mailer, adapter: Bamboo.LocalAdapter

config :sabor_brasileiro,
  access_token_secret:
    System.get_env("ACCESS_TOKEN_SECRET") ||
      raise("""
      environment variable ACCESS_TOKEN_SECRET is missing.
      type some random characters to create one
      """),
  refresh_token_secret:
    System.get_env("REFRESH_TOKEN_SECRET") ||
      raise("""
      environment variable REFRESH_TOKEN_SECRET is missing.
      type some random characters to create one
      """)

config :joken,
  access_token_secret: System.fetch_env!("ACCESS_TOKEN_SECRET"),
  refresh_token_secret: System.fetch_env!("REFRESH_TOKEN_SECRET")

config :sabor_brasileiro, SaborBrasileiroWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
