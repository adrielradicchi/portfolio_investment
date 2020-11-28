defmodule PortfolioInvestmentWeb.StockController do
  use PortfolioInvestmentWeb, :controller

  action_fallback PortfolioInvestmentWeb.FallbackController

  def show(conn, %{"name" => name}) do
    name
    |> PortfolioInvestment.fetch_stock()
    |> handle_response(conn)
  end

  defp handle_response({:ok, stock}, conn) do
    conn
    |> put_status(:ok)
    |> json(stock)
  end

  defp handle_response({:error, _reason} = error, _conn), do: error
  # defp handle_response({:error, _reason} = error, _conn), do: %{error: error, status: 404}
end
