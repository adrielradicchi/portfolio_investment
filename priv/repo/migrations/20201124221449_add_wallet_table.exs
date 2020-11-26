defmodule PortfolioInvestment.Repo.Migrations.AddWalletTable do
  use Ecto.Migration

  def change do
	create table(:wallets, primary_key: false) do
		add :id, :uuid, primary_key: true
		add :name, :string
		add :value_each_share, :decimal
		add :total_investments, :decimal
		add :amount_usa_stock_investment, :integer
		add :user_id, references(:users, type: :uuid, on_delete: :delete_all), null: false

		timestamps()
	end
  end
end
