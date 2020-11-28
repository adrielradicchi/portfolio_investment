defmodule PortfolioInvestmentWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :portfolio_investment

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
