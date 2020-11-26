# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("ecto://d96db040-1743-42f9-8c5c-8fe468a3424c-user:pw-5762f29d-5a77-45c4-b275-2815910854aa@postgres-free-tier-v2020.gigalixir.com:5432/d96db040-1743-42f9-8c5c-8fe468a3424c") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :portfolio_investment, PortfolioInvestment.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("2") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :portfolio_investment, PortfolioInvestmentWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :portfolio_investment, PortfolioInvestmentWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
