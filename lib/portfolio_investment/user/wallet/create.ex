defmodule PortfolioInvestment.User.Wallet.Create do

  alias Ecto.UUID
  alias PortfolioInvestment.{Repo,User.Wallet, User}

    def call(%{"user_id" => user_id} = params) do
      user_id
      |> UUID.cast()
      |> validate_uuid(params)
    end

    defp validate_uuid({:ok, uuid}, params), do: create_wallet(uuid, params)
    defp validate_uuid(:error,_params), do: {:error, %{message: "Invalid ID format!", status: 400}}

    defp fetch_user(uuid), do: Repo.get(User, uuid)

    defp create_wallet(uuid, params) when not is_nil(uuid) do
      uuid
      |> fetch_user()
      |> build_wallet(params)
    end

    defp create_wallet(_uuid, _params), do: {:error, %{message: "User not found", status: 404}}

    defp build_wallet(user, params) when not is_nil(user) do
      params
      |> Wallet.build()
      |> insert_wallet()
    end

    defp build_wallet({:error, _reason} = error, _params), do: error

    defp insert_wallet({:ok, struct}), do: Repo.insert(struct)
    defp insert_wallet({:error, _changeset} = error), do: error
end
