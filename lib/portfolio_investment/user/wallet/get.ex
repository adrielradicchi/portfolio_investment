defmodule PortfolioInvestment.User.Wallet.Get do

  alias Ecto.UUID
  alias PortfolioInvestment.{Repo, User.Wallet}

  def call(id) do
    id
    |> UUID.cast()
    |> validate_uuid()
  end

  defp get(uuid) do
    uuid
    |> fetch_wallet()
    |> get_stock_user()
  end

  defp validate_uuid({:ok, uuid}), do: get(uuid)
  defp validate_uuid(:error), do: {:error, %{message: "Invalid ID format!", status: 400}}

  defp fetch_wallet(uuid), do: Repo.get(Wallet, uuid)

  defp get_stock_user(wallet) when not is_nil(wallet), do: {:ok, Repo.preload(wallet, [:stock, :user])}
  defp get_stock_user(_stock), do: {:error, %{message: "Wallet not found", status: 404}}

end
