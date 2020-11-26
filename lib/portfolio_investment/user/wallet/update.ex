defmodule PortfolioInvestment.User.Wallet.Update do

  alias Ecto.UUID
  alias PortfolioInvestment.{Repo, User.Wallet}

  def call(%{"id" => uuid} = params) do
    uuid
    |> UUID.cast()
    |> validate_uuid(params)
  end

  defp update(%{"id" => uuid} = params) do
    uuid
    |> fetch_trainer()
    |> update_wallet(params)
  end

  defp validate_uuid({:ok, _uuid}, params), do: update(params)
  defp validate_uuid(:error, _params), do: {:error, %{message: "Invalid ID format!", status: 400}}

  defp fetch_trainer(uuid), do: Repo.get(Wallet, uuid)

  defp update_wallet(wallet, params) when not is_nil(wallet) do
    wallet
    |> Wallet.update_name_changeset(params)
    |> Repo.update()
  end

  defp update_wallet(_wallet, _params), do: {:error, %{message: "Wallet not found", status: 404}}

end
