defmodule PortfolioInvestment.User.Wallet.Stock.Create do
  alias Ecto.UUID
  alias PortfolioInvestment.Stock.Get
  alias PortfolioInvestment.{Repo, Stock, User}
  alias PortfolioInvestment.User.Wallet
  alias PortfolioInvestment.User.Wallet.Stock, as: StockWallet

  def call(%{"ticker" => ticker} = params) do
    ticker
    |> Get.call()
    |> create_stock(params)
  end

  defp create_stock({:ok, %Stock{price: price, region: region, volume: volume}}, %{"ticker" => ticker, "amount" => amount, "wallet_id" => wallet_id})do
    params = %{
      ticker: ticker,
      price: String.to_float(price),
      amount: amount,
      region: region,
      volume: volume,
      total_stock: String.to_float(price) * String.to_integer(amount),
      wallet_id: wallet_id
    }

    {user, wallet, params} = params
    |> validate()

    params
    |> StockWallet.build()
    |> handle_build()
    |> update_wallet(user, wallet)
  end

  defp create_stock({:error, _reason} = error, _params), do: error

  defp validate(%{wallet_id: wallet_id, amount: amount, volume: volume} = stock) when not is_nil(stock) do
    with {:ok, true} <- is_amount_less_or_equal_than_volume(String.to_integer(amount), String.to_integer(volume)) do
      wallet_id
      |> UUID.cast()
      |> validate_wallet(stock)
    end
  end

  defp is_amount_less_or_equal_than_volume(amount, volume) when amount <= volume, do: {:ok, true}
  defp is_amount_less_or_equal_than_volume(amount, volume) when amount > volume, do: {:error, %{message: "The number of shares is greater than the amount available!", status: 400}}

  defp validate_wallet({:ok, wallet_id}, stock), do: get_wallet(wallet_id, stock)
  defp validate_wallet(:error, _stock), do: {:error, %{message: "Invalid ID format!", status: 400}}

  defp get_wallet(wallet_id, stock) do
    wallet_id
    |> fetch_wallet(stock)
    |> get_wallet_stock()
    |> fetch_user()
    |> get_user_wallet_stock()
    |> validate_update_wallet()
  end

  defp fetch_wallet(wallet_id, stock), do: {Repo.get(Wallet, wallet_id), stock}

  defp fetch_user({%Wallet{user_id: user_id} = wallet, stock}), do: {Repo.get(User, user_id), wallet ,stock}

  defp is_american_stock(region) when region == "United States", do: {:ok, true}

  defp is_american_stock(region) when region != "United States", do: {:error, false}

  defp is_investment_limit_less_or_equal_than_total_investments(investment_limit, total_investments)
  when total_investments <= investment_limit, do: {:ok, true}

  defp is_investment_limit_less_or_equal_than_total_investments(investment_limit, total_investments)
    when total_investments > investment_limit, do: {:error, %{message: "The investment limit is over.", status: 400}}

  defp is_total_stock_less_or_equal_than_amount_usa_stock_investment(usa_stock_limit, amount_usa_stock_investment)
    when amount_usa_stock_investment <= usa_stock_limit, do: {:ok, true}

  defp is_total_stock_less_or_equal_than_amount_usa_stock_investment(usa_stock_limit, amount_usa_stock_investment)
    when amount_usa_stock_investment > usa_stock_limit, do: {:error, %{message: "Number of shares of American companies reached. You will not be able to register new shares of American companies.", status: 400}}

  defp validate_update_wallet(
    {%User{investment_limit: investment_limit, usa_stock_limit: usa_stock_limit} = user,
    %Wallet{total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment} = wallet,
    %{total_stock: total_stock, region: region} = stock}) do
    amount_usa_stock = amount_usa_stock_investment + 1
    total_investment_stock = Decimal.to_float(total_investments) + total_stock
    with {:ok, true} <- is_american_stock(region),
         {:ok, true} <- is_total_stock_less_or_equal_than_amount_usa_stock_investment(usa_stock_limit, amount_usa_stock),
         {:ok, true} <- is_investment_limit_less_or_equal_than_total_investments(Decimal.to_float(investment_limit), total_investment_stock)
      do
        {user, wallet, stock}
      else
        {:error, false} ->
          case is_investment_limit_less_or_equal_than_total_investments(Decimal.to_float(investment_limit), total_investment_stock) do
            {:ok, true} -> {user, wallet, stock}
            error -> {user, wallet, error}
          end
        error -> {user, wallet, error}
    end
  end

  defp get_wallet_stock({wallet, stock}) when not is_nil(wallet) do
    {wallet, stock}
  end
  defp get_wallet_stock({_user, _stock}), do: {:error, %{message: "Wallet not found", status: 404}}

  defp get_user_wallet_stock({user, wallet, stock}) when not is_nil(user), do: {user, wallet, stock}
  defp get_user_wallet_stock({_user, _wallet, _stock}), do: {:error, %{message: "User not found", status: 404}}

  defp handle_build({:ok, stock}), do: Repo.insert(stock)
  defp handle_build({:error, _changeset} = error), do: error

  defp update_wallet(
    {:ok, %StockWallet{total_stock: total_stock, region: region, price: price} = stock},
    %User{investment_limit: investment_limit, usa_stock_limit: usa_stock_limit},
    %Wallet{total_investments: total_investments, amount_usa_stock_investment: amount_usa_stock_investment, value_each_share: value_each_share} = wallet)
  do
    amount_usa_stock = amount_usa_stock_investment + 1
    total_investment_stock = Decimal.to_float(total_investments) + Decimal.to_float(total_stock)
    with {:ok, true} <- is_american_stock(region),
         {:ok, true} <- is_total_stock_less_or_equal_than_amount_usa_stock_investment(usa_stock_limit, amount_usa_stock),
         {:ok, true} <- is_investment_limit_less_or_equal_than_total_investments(investment_limit, total_investment_stock)
      do
      params_update_amount_usa_stock_investment = %{
        amount_usa_stock_investment: amount_usa_stock,
        total_investments: total_investment_stock,
        value_each_share: Decimal.to_float(value_each_share) + Decimal.to_float(price)
      }

      params_update_amount_usa_stock_investment
      |> Wallet.update_stock_changeset(wallet)
      |> Repo.update()

      {:ok, stock}
      else
        {:error, false} ->
          case is_investment_limit_less_or_equal_than_total_investments(investment_limit, total_investment_stock) do
            {:ok, true} ->
              params_update_amount_usa_stock_investment = %{
                total_investments: total_investment_stock,
                value_each_share: Decimal.to_float(value_each_share) + Decimal.to_float(price)
              }

              params_update_amount_usa_stock_investment
              |> Wallet.update_stock_changeset(wallet)
              |> Repo.update()

              {:ok, stock}

              error -> error
          end
          error -> error
     end
  end

  defp update_wallet({:error, _reason} = error, _user, _wallet), do: error
end
