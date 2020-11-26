defmodule PortfolioInvestment.User.Wallet.Stock.Get do

  alias Ecto.UUID
  alias PortfolioInvestment.{Repo, User.Wallet.Stock}

  def call(id) do
    id
    |> UUID.cast()
    |> validate_uuid()
  end

  defp get(uuid) do
    uuid
    |> fetch_stock()
    |> get_wallet()
  end

  defp validate_uuid({:ok, uuid}), do: get(uuid)
  defp validate_uuid(:error), do: {:error, %{message: "Invalid ID format!", status: 400}}

  defp fetch_stock(uuid), do: Repo.get(Stock, uuid)

  defp get_wallet(stock) when not is_nil(stock), do: {:ok, Repo.preload(stock, :wallet)}
  defp get_wallet(_stock), do: {:error, %{message: "Wallet not found", status: 404}}

end
