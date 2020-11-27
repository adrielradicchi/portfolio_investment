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

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  origin: ["http://localhost:3000", "https://enigmatic-springs-21467.herokuapp.com/", "https://portfolio-investment-web.herokuapp.com/"],
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "DELETE"],
  send_preflight_response?: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
