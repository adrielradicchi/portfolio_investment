defmodule PortfolioInvestmentWeb.WalletStocksController do
  use PortfolioInvestmentWeb, :controller

  action_fallback PortfolioInvestmentWeb.FallbackController

  def create(conn, params) do
    params
    |> PortfolioInvestment.create_wallet_stock()
    |> handle_response(conn, "create.json", :created)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> PortfolioInvestment.delete_wallet_stock()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> PortfolioInvestment.fetch_wallet_stock()
    |> handle_response(conn, "show.json", :ok)
  end

  defp handle_delete({:ok, _stock}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete({:error, _reason} = error, _conn), do: error

  defp handle_response({:ok, stock}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, stock: stock)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
