defmodule PortfolioInvestment.Repo.Migrations.AddStockTable do
  use Ecto.Migration

  def change do
    create table(:stock, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :ticker, :string
      add :region, :string
      add :price, :decimal
      add :amount, :integer
      add :total_stock, :decimal
      add :wallet_id, references(:wallets, type: :uuid, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
