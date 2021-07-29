defmodule SaborBrasileiro.Users.Show do
  alias Ecto.Multi
  alias SaborBrasileiro.{User, Repo, Users.Queries}

  def call(%{user: %User{} = user}), do: {:ok, user}

  def call(%{user_id: user_id}) do
    Multi.new()
    |> Multi.run(:get_user, fn repo, _ ->
      get_user(repo, user_id)
    end)
    |> Queries.preload_data(:get_user)
    |> run_transaction
  end

  defp get_user(repo, user_id) do
    Queries.get_with(%{"id" => user_id})
    |> repo.one
    |> handle_user
  end

  defp handle_user(%User{} = user), do: {:ok, user}
  defp handle_user(_), do: {:error, "User not found"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_user_data: user}} -> {:ok, user}
    end
  end
end
