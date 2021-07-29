defmodule SaborBrasileiro.Users.Find do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, Users.Queries}

  def call(query) do
    Multi.new()
    |> Multi.run(:get_users, fn repo, _ ->
      get_users(repo, query)
    end)
    |> Queries.preload_data(:get_users)
    |> run_transaction
  end

  defp get_users(repo, query) do
    Queries.get_with(query)
    |> repo.all()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_user_data: users}} -> {:ok, users}
    end
  end
end
