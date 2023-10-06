import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Calculator.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

config :cors_plug,
  origin: [~r/^https?.*calculator-client-i3ta78y3d-minerado.vercel.app.*$/],
  max_age: 86400,
  methods: ["*"]

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
