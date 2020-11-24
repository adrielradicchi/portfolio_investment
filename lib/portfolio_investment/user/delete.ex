defmodule PortfolioInvestment.User.Delete do

	alias Ecto.UUID
	alias PortfolioInvestment.{Repo, User}

	def call(id) do
		id
		|> UUID.cast()
		|> validate_uuid()
	end

	defp delete(uuid) do
		uuid
		|> fetch_user()
		|> delete_user()
	end

	defp validate_uuid({:ok, uuid}), do: delete(uuid)
	defp validate_uuid(:error), do: {:error, %{message: "Invalid ID format!", status: 400}}

	defp fetch_user(uuid), do: Repo.get(User, uuid)

	defp delete_user(user) when not is_nil(user), do: Repo.delete(user)
	defp delete_user(_user), do: {:error, %{message: "User not found", status: 404}}
end
