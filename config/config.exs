# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :portfolio_investment,
  ecto_repos: [PortfolioInvestment.Repo]

# Configures the endpoint
config :portfolio_investment, PortfolioInvestmentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ob0cWaLY4JlR+5rB8XDCS4YQNubcaJNII9gCwnr9o30M41c4uL8ApMbckSfKSSt8",
  render_errors: [view: PortfolioInvestmentWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PortfolioInvestment.PubSub,
  live_view: [signing_salt: "hXhnTpHn"]

config :cors_plug,
  origin: ["*"],
  max_age: 86400,
  methods: ["GET", "POST","OPTIONS","PUT","DELETE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :portfolio_investment, PortfolioInvestmentWeb.Auth.Guardian,
  issuer: "portfolio_investment",
  secret_key: "dvD1E5DjCNc8Py45ym/dVuFYBhD9qfcfWo4lFByybe3wp5ZJJEz0RlDC/HZh+qtT"

config :portfolio_investment, PortfolioInvestmentWeb.Auth.Pipeline,
  module: PortfolioInvestmentWeb.Auth.Guardian,
  error_handler: PortfolioInvestmentWeb.Auth.ErrorHandler,
  token_type: ["access","refresh"],
  ttl: {1, :day}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
