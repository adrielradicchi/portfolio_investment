defmodule PortfolioInvestmentWeb.UsersView do
  use PortfolioInvestmentWeb, :view

  alias PortfolioInvestment.{User, User.Wallet}

  def render("create.json", %{user: %User{id: id, name: name, email: email, investment_limit: investment_limit, usa_stock_limit: usa_stock_limit, inserted_at: inserted_at}, token: token}) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        email: email,
        investment_limit: investment_limit,
        usa_stock_limit: usa_stock_limit,
        inserted_at: inserted_at
      },
      token: token
    }
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}

  def render("update.json", %{user: %User{id: id, name: name, email: email, investment_limit: investment_limit, usa_stock_limit: usa_stock_limit, inserted_at: inserted_at, updated_at: updated_at}}) do
    %{
      message: "User updated!",
      user: %{
        id: id,
        name: name,
        email: email,
        investment_limit: investment_limit,
        usa_stock_limit: usa_stock_limit,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("show.json", %{user: %User{id: id, name: name, email: email, investment_limit: investment_limit, usa_stock_limit: usa_stock_limit, wallet: wallets, inserted_at: inserted_at}}) do
    %{
      id: id,
      name: name,
      email: email,
      investment_limit: investment_limit,
      usa_stock_limit: usa_stock_limit,
      wallet: show_all_wallets(wallets),
      inserted_at: inserted_at
    }
  end

  defp show_all_wallets(wallets) do
    wallets
    |> Enum.map(&show_wallet(&1))
  end

  defp show_wallet(%Wallet{id: id, name: name, value_each_share: value_each_share, total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment}) do
    %{
      id: id,
      name: name,
      value_each_share: value_each_share,
      total_investments: total_investments,
      amount_usa_stock_investment: amount_usa_stock_investment
    }
  end
end
