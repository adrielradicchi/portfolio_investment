defmodule PortfolioInvestment.User do
    use Ecto.Schema
    import Ecto.Changeset

    alias PortfolioInvestment.User.Wallet

    @primary_key {:id, Ecto.UUID, autogenerate: true}

    schema "users" do
        field :name, :string
        field :email, :string
        field :password, :string, virtual: true
        field :password_hash, :string
        field :investment_limit, :decimal
        field :usa_stock_limit, :integer
        has_many(:wallet, Wallet)

        timestamps()
    end

    def build(params) do
        params
        |> changeset()
        |> apply_action(:insert)
    end

    @required_params [:name, :email, :password, :investment_limit, :usa_stock_limit]

    def changeset(params), do: create_changeset(%__MODULE__{}, params)

    def changeset(user, params), do: create_changeset(user, params)

    defp create_changeset(module_or_user, params) do
        module_or_user
        |> cast(params, @required_params)
        |> validate_required(@required_params)
        |> validate_format(:email, ~r/^[A-Za-z0-9\._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$/)
        |> validate_length(:password, min: 6)
        |> put_pass_hash()
    end

    def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
        change(changeset, Argon2.add_hash(password))
    end

    def put_pass_hash(changeset), do: changeset
end
