defmodule PortfolioInvestment do
  alias PortfolioInvestment.{User, Stock}
  alias User.Wallet
  alias User.Wallet.Stock, as: WalletStock

  defdelegate create_user(params), to: User.Create, as: :call
  defdelegate delete_user(params), to: User.Delete, as: :call
  defdelegate fetch_user(params), to: User.Get, as: :call
  defdelegate update_user(params), to: User.Update, as: :call
  defdelegate fetch_stock(params), to: Stock.Get, as: :call
  defdelegate fetch_stock_global_quote(params), to: Stock.GetStockGlobalQuote, as: :call
  defdelegate fetch_stock_symbol_search(stock, params), to: Stock.GetStockSymbolSearch, as: :call
  defdelegate create_wallet(params), to: Wallet.Create, as: :call
  defdelegate fetch_wallet(params), to: Wallet.Get, as: :call
  defdelegate delete_wallet(params), to: Wallet.Delete, as: :call
  defdelegate update_wallet(params), to: Wallet.Update, as: :call
  defdelegate create_wallet_stock(params), to: WalletStock.Create, as: :call
  defdelegate fetch_wallet_stock(params), to: WalletStock.Get, as: :call
  defdelegate delete_wallet_stock(params), to: WalletStock.Delete, as: :call
end
