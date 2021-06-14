defmodule SaborBrasileiro.BestConfectioners.Find do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo}

  import SaborBrasileiro.BestConfectioners.Queries,
    only: [get_all_best_confectioners: 2, get_best_confectioners_by_name: 2]

  def call(query) do
    multi = Multi.new()

    case query do
      %{"name" => name} ->
        multi |> get_best_confectioners_by_name(name) |> run_transaction

      _any_value ->
        multi |> get_all_best_confectioners(%{limit: query["_limit"]}) |> run_transaction
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_best_confectioner_data: best_confectioners}} -> {:ok, best_confectioners}
    end
  end
end
