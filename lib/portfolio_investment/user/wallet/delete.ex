defmodule PortfolioInvestment.User.Wallet.Delete do

  alias Ecto.UUID
  alias PortfolioInvestment.{Repo, User.Wallet}

  def call(id) do
    id
    |> UUID.cast()
    |> validate_uuid()
  end

  defp delete(uuid) do
    uuid
    |> fetch_wallet()
    |> delete_wallet()
  end

  defp validate_uuid({:ok, uuid}), do: delete(uuid)
  defp validate_uuid(:error), do: {:error, %{message: "Invalid ID format!", status: 400}}

  defp fetch_wallet(uuid), do: Repo.get(Wallet, uuid)

  defp delete_wallet(wallet) when not is_nil(wallet), do: Repo.delete(wallet)
  defp delete_wallet(_wallet), do: {:error, %{message: "Wallet not found", status: 404}}

end
