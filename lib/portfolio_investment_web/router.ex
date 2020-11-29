defmodule PortfolioInvestmentWeb.Router do
  use PortfolioInvestmentWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*", max_age: 86400, methods: ["*"]
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PortfolioInvestmentWeb.Auth.Pipeline
  end

  scope "/api", PortfolioInvestmentWeb do
    pipe_through :api

    post "/users", UsersController, :create
    post "/users/signin", UsersController, :sign_in

  end

  scope "/api", PortfolioInvestmentWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, only: [:show, :delete, :update]
    get "/stocks/:name", StockController, :show
    resources "/wallets", UserWalletsController, only: [:create, :show, :delete, :update]
    resources "/wallet_stocks", WalletStocksController, only: [:create, :show, :delete, :update]

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
