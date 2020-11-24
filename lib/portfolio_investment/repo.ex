defmodule PortfolioInvestment.Repo do
  use Ecto.Repo,
    otp_app: :portfolio_investment,
    adapter: Ecto.Adapters.Postgres
end
