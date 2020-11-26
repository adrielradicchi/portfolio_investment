defmodule PortfolioInvestmentWeb.WalletStocksView do
  use PortfolioInvestmentWeb, :view

  alias PortfolioInvestment.User.Wallet.Stock
  alias PortfolioInvestment.User.Wallet
  # alias PortfolioInvestment.User

  def render("create.json", %{stock: %Stock{id: id, ticker: ticker, price: price, amount: amount, region: region, total_stock: total_stock, wallet_id: wallet_id, inserted_at: inserted_at}}) do
    %{
      message: "Wallet created!",
      Stock: %{
        id: id,
        ticker: ticker,
        price: price,
        amount: amount,
        region: region,
        total_stock: total_stock,
        wallet_id: wallet_id,
        inserted_at: inserted_at
      }
    }
  end

  def render("update.json", %{stock: %Stock{id: id, ticker: ticker, price: price, amount: amount, region: region, total_stock: total_stock, wallet_id: wallet_id, inserted_at: inserted_at, updated_at: updated_at}}) do
    %{
      message: "Wallet updated!",
      Stock: %{
        id: id,
        ticker: ticker,
        price: price,
        amount: amount,
        region: region,
        total_stock: total_stock,
        wallet_id: wallet_id,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  # def render("show.json",
  # %{stock: %Stock{id: id, ticker: ticker, price: price, amount: amount, region: region, total_stock: total_stock, wallet: %Wallet{id: id, name: name, value_each_share: value_each_share, total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment, user: %User{id: user_id, name: user_name, email: email,investment_limit: investment_limit,usa_stock_limit: usa_stock_limit}}, inserted_at: inserted_at}}) do
  def render("show.json", %{stock: %Stock{id: id, ticker: ticker, price: price, amount: amount, region: region, total_stock: total_stock, wallet: %Wallet{id: wallet_id, name: name, value_each_share: value_each_share, total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment, user_id: user_id}, inserted_at: inserted_at}}) do
    %{
      id: id,
      ticker: ticker,
      price: price,
      amount: amount,
      region: region,
      total_stock: total_stock,
      wallet: %{
        id: wallet_id,
        name: name,
        value_each_share: value_each_share,
        total_investments: total_investments,
        amount_usa_stock_investment: amount_usa_stock_investment,
      #   # user: %{
      #   #   id: user_id,
      #   #   name: user_name,
      #   #   email: email,
      #   #   investment_limit: investment_limit,
      #   #   usa_stock_limit: usa_stock_limit,
      #   # }
        user_id: user_id
      },
      inserted_at: inserted_at
    }
  end
end
