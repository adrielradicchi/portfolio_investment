defmodule PortfolioInvestment.AlphaVentageAPI.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.alphavantage.co"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Query, [apikey: "QL1W30DHT3EBTU3O"]

  def get_stock(query) do
    query
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_get({:ok, %Tesla.Env{status: 404 }}), do: {:error, %{message: "Stock not found!", status: 404}}
  defp handle_get({:error, _reason} = error), do: error

end
