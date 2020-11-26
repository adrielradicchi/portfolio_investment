defmodule PortfolioInvestment.User.Get do

	alias Ecto.UUID
	alias PortfolioInvestment.{Repo, User}

	def call(id) do
		id
		|> UUID.cast()
		|> validate_uuid()
	end

	defp get(uuid) do
		uuid
		|> fetch_user()
		|> get_user()
	end

	defp validate_uuid({:ok, uuid}), do: get(uuid)
	defp validate_uuid(:error), do: {:error, %{message: "Invalid ID format!", status: 400}}

	defp fetch_user(uuid), do: Repo.get(User, uuid)

	defp get_user(user) when not is_nil(user), do: {:ok, Repo.preload(user, :wallet)}
	defp get_user(_user), do: {:error, %{message: "User not found", status: 404}}
end
