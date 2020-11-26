defmodule PortfolioInvestmentWeb.UserWalletsView do
  use PortfolioInvestmentWeb, :view

  alias PortfolioInvestment.{User, User.Wallet, User.Wallet.Stock}

  def render("create.json", %{wallet: %Wallet{id: id, name: name, value_each_share: value_each_share, total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment, user_id: user_id,inserted_at: inserted_at}}) do
    %{
      message: "Wallet created!",
      wallet: %{
        id: id,
        name: name,
        value_each_share: value_each_share,
        total_investments: total_investments,
        amount_usa_stock_investment: amount_usa_stock_investment,
        user_id: user_id,
        inserted_at: inserted_at
      }
    }
  end

  def render("update.json", %{wallet: %Wallet{id: id, name: name, value_each_share: value_each_share, total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment, user_id: user_id,inserted_at: inserted_at, updated_at: updated_at}}) do
    %{
      message: "Wallet updated!",
      wallet: %{
        id: id,
        name: name,
        value_each_share: value_each_share,
        total_investments: total_investments,
        amount_usa_stock_investment: amount_usa_stock_investment,
        user_id: user_id,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("show.json",
  %{wallet: %Wallet{id: id, name: name, value_each_share: value_each_share, total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment, user: %User{id: user_id, name: user_name, email: email,investment_limit: investment_limit,usa_stock_limit: usa_stock_limit}, stock: stock, inserted_at: inserted_at}}) do
    %{
      id: id,
      name: name,
      value_each_share: value_each_share,
      total_investments: total_investments,
      amount_usa_stock_investment: amount_usa_stock_investment,
      user: %{
        id: user_id,
        name: user_name,
        email: email,
        investment_limit: investment_limit,
        usa_stock_limit: usa_stock_limit,
      },
      stock: show_all_stock(stock),
      inserted_at: inserted_at
    }
  end

  defp show_all_stock(stock) do
    stock
    |> Enum.map(&show_stock(&1))
  end

  defp show_stock(%Stock{id: id, ticker: ticker, price: price, amount: amount, region: region, total_stock: total_stock}) do
    %{
      id: id,
      ticker: ticker,
      price: price,
      amount: amount,
      region: region,
      total_stock: total_stock
    }
  end
end
