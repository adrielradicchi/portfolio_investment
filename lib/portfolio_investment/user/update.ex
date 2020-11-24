defmodule PortfolioInvestment.User.Update do

	alias Ecto.UUID
	alias PortfolioInvestment.{Repo, User}

	def call(%{"id" => uuid} = params) do
		uuid
		|> UUID.cast()
		|> validate_uuid(params)
	end

	defp update(%{"id" => uuid} = params) do
		uuid
		|> fetch_user()
		|> update_user(params)
	end

	defp validate_uuid({:ok, _uuid}, params), do: update(params)
	defp validate_uuid(:error, _params), do: {:error, %{message: "Invalid ID format!", status: 400}}

	defp fetch_user(uuid), do: Repo.get(User, uuid)

	defp update_user(user, params) when not is_nil(user) do
		user
		|> User.changeset(params)
		|> Repo.update()
	end

	defp update_user(_User, _params), do: {:error, %{message: "User not found", status: 404}}
end
