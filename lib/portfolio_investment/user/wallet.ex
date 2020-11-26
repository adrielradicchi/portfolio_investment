defmodule PortfolioInvestment.User.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  alias PortfolioInvestment.User
  alias PortfolioInvestment.User.Wallet.Stock

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "wallets" do
    field :name, :string
    field :value_each_share, :decimal
    field :total_investments, :decimal
    field :amount_usa_stock_investment, :integer

    belongs_to(:user, User)
    has_many(:stock, Stock)

    timestamps()
  end

  @required [:name, :user_id, :value_each_share, :total_investments, :amount_usa_stock_investment]

  def build(params) when not is_map_key(params, :error) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def build({:error, _reason} = error), do: error

  defp changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
    |> assoc_constraint(:user)
  end

  def update_name_changeset(wallet, params) do
    wallet
    |> cast(params, [:name])
    |> validate_required([:name])
  end

@required_update [:value_each_share, :total_investments, :amount_usa_stock_investment]

  def update_stock_changeset(params, wallet) do
    wallet
    |> cast(params, @required_update)
    |> validate_required(@required_update)
  end
end
