defmodule PortfolioInvestmentWeb.Auth.Guardian do
  use Guardian, otp_app: :portfolio_investment


  alias PortfolioInvestment.{Repo, User}
  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> PortfolioInvestment.fetch_user()
  end

  def authenticate(%{"email" => email, "password" => password}) do
    email
    |> get_user()
    |> validate_user(password)
  end

  defp get_user(email), do: Repo.get_by(User, email: email)

  defp validate_user(user, password) when not is_nil(user) and (byte_size(password) >= 6), do: validate_password(user, password)
  defp validate_user(user, _password) when is_nil(user), do: {:error, %{message: "User not found", status: 404}}

  defp validate_password(%User{password_hash: hash} = user, password) do
    Argon2.verify_pass(password, hash)
    |> create_token(user)
  end

  defp validate_password({:error, _reason} = error, _password), do: error

  defp create_token(is_valid_password, user) when is_valid_password == true do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token}
  end

  defp create_token(is_valid_password, _user) when is_valid_password == false, do: {:error, %{message: "User unauthorized", status: 401}}
end
