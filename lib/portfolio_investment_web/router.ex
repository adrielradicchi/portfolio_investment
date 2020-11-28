defmodule PortfolioInvestmentWeb.Router do
  use PortfolioInvestmentWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*", max_age: 86400, methods: ["GET", "POST","OPTIONS","PUT","DELETE"]
    plug :accepts, ["json"]
  end


  scope "/api", PortfolioInvestmentWeb do
    pipe_through :api

    # post "/users", UsersController, :create
    # options "/users", UsersController, :options
    resources "/users", UsersController
    resources "/wallets", UserWalletsController
    resources "/stock", WalletStocksController

  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PortfolioInvestmentWeb.Telemetry
    end
  end
end
