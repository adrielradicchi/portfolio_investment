defmodule PortfolioInvestmentWeb.UsersView do
  use PortfolioInvestmentWeb, :view

  alias PortfolioInvestment.{User}

  def render("create.json", %{user: %User{id: id, name: name, email: email, investment_limit: investment_limit, inserted_at: inserted_at}}) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        email: email,
        investment_limit: investment_limit,
        inserted_at: inserted_at
      }
    }
  end

  def render("update.json", %{user: %User{id: id, name: name, email: email, investment_limit: investment_limit, inserted_at: inserted_at, updated_at: updated_at}}) do
    %{
      message: "User updated!",
      user: %{
        id: id,
        name: name,
        email: email,
        investment_limit: investment_limit,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("show.json", %{user: %User{id: id, name: name, email: email, investment_limit: investment_limit, inserted_at: inserted_at}}) do
    %{
      id: id,
      name: name,
      email: email,
      investment_limit: investment_limit,
      inserted_at: inserted_at
    }
  end
end
