defmodule PortfolioInvestment.User.Wallet.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  alias PortfolioInvestment.User.Wallet

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "stock" do
    field :ticker, :string
    field :price, :decimal
    field :amount, :integer
    field :region, :string
    field :volume, :decimal, virtual: true
    field :total_stock, :decimal

    belongs_to(:wallet, Wallet)
    timestamps()
  end

  @required [:ticker, :price, :amount, :region, :total_stock, :wallet_id]

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
    |> assoc_constraint(:wallet)
  end

end
