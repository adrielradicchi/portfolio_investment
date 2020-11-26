defmodule PortfolioInvestmentWeb.UserWalletsController do
  use PortfolioInvestmentWeb, :controller

  action_fallback PortfolioInvestmentWeb.FallbackController

  def create(conn, params) do
    params
    |> PortfolioInvestment.create_wallet()
    |> handle_response(conn, "create.json", :created)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> PortfolioInvestment.delete_wallet()
    |> handle_delete(conn)
  end

  def show(conn, %{"id" => id}) do
    id
    |> PortfolioInvestment.fetch_wallet()
    |> handle_response(conn, "show.json", :ok)
  end

  def update(conn, params) do
    params
    |> PortfolioInvestment.update_wallet()
    |> handle_response(conn, "update.json", :ok)
  end

  defp handle_delete({:ok, _wallet}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete({:error, _reason} = error, _conn), do: error

  defp handle_response({:ok, wallet}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, wallet: wallet)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
