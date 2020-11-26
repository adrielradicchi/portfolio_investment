defmodule PortfolioInvestment.Stock.Get do

  alias PortfolioInvestment.Stock.{GetStockGlobalQuote, GetStockSymbolSearch}

  def call(%{"ticker" => ticker}) do
    ticker
    |> GetStockGlobalQuote.call()
    |> GetStockSymbolSearch.call(ticker)
  end

  def call(ticker) when is_bitstring(ticker) do
    ticker
    |> GetStockGlobalQuote.call()
    |> GetStockSymbolSearch.call(ticker)
  end
end
