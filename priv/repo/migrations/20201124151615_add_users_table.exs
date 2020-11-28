defmodule PortfolioInvestment.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :investment_limit, :decimal
      add :usa_stock_limit, :integer
      timestamps()
    end

    create unique_index(:users, :email, name: :unique_email)
  end
end
