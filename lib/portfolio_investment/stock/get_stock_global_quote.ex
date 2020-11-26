defmodule PortfolioInvestment.Stock.GetStockGlobalQuote do

  alias PortfolioInvestment.AlphaVentageAPI.Client
  alias PortfolioInvestment.Stock

  def call(name) do
    "/query?function=GLOBAL_QUOTE&symbol=#{name}"
    |> Client.get_stock()
    |> handle_response()
  end

  defp handle_response({:ok, body}), do: Stock.build(body)
  defp handle_response({:error, %{status: 404}} = error), do: error
  defp handle_response({:error, _reason} = error), do: error
end
