defmodule PortfolioInvestment.Stock.GetStockSymbolSearch do

  alias PortfolioInvestment.AlphaVentageAPI.Client
  alias PortfolioInvestment.Stock

  def call({:ok, stock}, name) do
    "/query?function=SYMBOL_SEARCH&keywords=#{name}"
    |> Client.get_stock()
    |> handle_response(stock)
  end

  def call({:error, %{status: 404}} = error, _name), do: error
  def call({:error, _reason} = error, _name), do: error

  defp handle_response({:ok, body}, stock), do: Stock.build(body, stock)
  defp handle_response({:error, %{status: 404}} = error, _stock), do: error
  defp handle_response({:error, _reason} = error, _stock), do: error
end
