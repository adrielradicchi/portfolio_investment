defmodule PortfolioInvestment.User.Wallet.Stock.Delete do

  alias Ecto.UUID
  alias PortfolioInvestment.{Repo, User.Wallet.Stock}

  def call(id) do
    id
    |> UUID.cast()
    |> validate_uuid()
  end

  defp delete(uuid) do
    uuid
    |> fetch_stock()
    |> delete_stock()
  end

  defp validate_uuid({:ok, uuid}), do: delete(uuid)
  defp validate_uuid(:error), do: {:error, %{message: "Invalid ID format!", status: 400}}

  defp fetch_stock(uuid), do: Repo.get(Stock, uuid)

  defp delete_stock(stock) when not is_nil(stock), do: Repo.delete(stock)
  defp delete_stock(_trainer), do: {:error, %{message: "Stock not found", status: 404}}

end
