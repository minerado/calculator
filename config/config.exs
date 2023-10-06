# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :calculator,
  ecto_repos: [Calculator.Repo]

# Configures the endpoint
config :calculator, CalculatorWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: CalculatorWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Calculator.PubSub,
  live_view: [signing_salt: "JUVg/WQP"]

config :calculator, Calculator.Guardian,
  issuer: "calculator",
  secret_key: "Co3/agGZb8ra72o2ztLaNre8ovqJldnjDJ1+yd4ZKfiKa3ihvXA1sbQYSfc7e8wR"

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :calculator, Calculator.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
