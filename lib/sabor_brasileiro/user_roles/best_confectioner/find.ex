defmodule SaborBrasileiro.UserRoles.BestConfectioners.Find do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, UserRoles.BestConfectioners.Queries, Users}

  def call(query) do
    Multi.new()
    |> Multi.run(:get_best_confectioners, fn repo, _ ->
      get_best_confectioners(repo, query)
    end)
    |> Users.Queries.preload_data(:get_best_confectioners)
    |> run_transaction
  end

  defp get_best_confectioners(repo, query) do
    Queries.get_with(query)
    |> repo.all()
    |> handle_best_confectioners
  end

  defp handle_best_confectioners([]), do: {:error, "Best Confectioners not found"}
  defp handle_best_confectioners(best_confectioners), do: {:ok, best_confectioners}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_user_data: users}} -> {:ok, users}
    end
  end
end
