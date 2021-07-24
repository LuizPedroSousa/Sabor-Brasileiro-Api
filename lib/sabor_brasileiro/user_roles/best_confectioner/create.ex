defmodule SaborBrasileiro.UserRoles.BestConfectioners.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Users, User, Repo}

  def call(params) do
    Multi.new()
    |> Multi.run(:get_confectioner, fn repo, _ ->
      get_confectioner(repo, params)
    end)
    |> Multi.update(:turn_best_confectioner, fn %{get_confectioner: %User{} = user} ->
      User.changeset_update(user, %{isBestConfectioner: true}) |> IO.inspect()
    end)
    |> Users.Queries.preload_data(:turn_best_confectioner)
    |> run_transaction
  end

  defp get_confectioner(repo, %{"confectioner_id" => confectioner_id}) do
    Users.Queries.get_with(%{"id" => confectioner_id})
    |> repo.one()
    |> handle_confectioner
  end

  defp get_confectioner(_repo, _), do: {:error, %{confectioner_id: ["can't be blank"]}}

  defp handle_confectioner(%User{isBestConfectioner: true}),
    do: {:error, "User already is a best confectioner"}

  defp handle_confectioner(%User{isConfectioner: true} = user), do: {:ok, user}
  defp handle_confectioner(%User{}), do: {:error, "User is not a confectioner"}
  defp handle_confectioner(_), do: {:error, "User not found"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_user_data: user}} -> {:ok, user}
    end
  end
end
