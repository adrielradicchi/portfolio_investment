defmodule PortfolioInvestment.Stock do
	@keys [:symbol, :price, :volume, :region]

	@enforce_keys @keys

	@derive Jason.Encoder

	defstruct @keys

	def build(%{"Global Quote" => %{"01. symbol" => symbol, "05. price" => price, "06. volume" => volume} = global_quote}) when map_size(global_quote) > 0 do
		{:ok,
			%__MODULE__{
				symbol: symbol,
				price: price,
				volume: volume,
				region: ""
			}
		}
	end

	def build(%{"Global Quote" => %{}}), do: {:error, %{message: "Ticker not Found!", status: 404}}

	def build(%{"Note" => error}) when not is_nil(error), do: {:error, %{message: error, status: 400}}

	def build(%{"bestMatches" => [%{"4. region" => region} | _tail]}, stock) when not is_nil(stock) do
		{:ok,
			%__MODULE__{
				symbol: stock.symbol,
				price:  stock.price,
				volume: stock.volume,
				region: region
			}
		}
	end

	def build(%{"bestMatches" => [] = bestMatches}, stock) when length(bestMatches) == 0 and not is_nil(stock), do: {:error, %{message: "Ticker not Found!", status: 404}}


end
