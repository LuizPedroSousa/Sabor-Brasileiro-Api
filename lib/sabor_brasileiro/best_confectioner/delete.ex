defmodule SaborBrasileiro.BestConfectioners.Delete do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo}
  import SaborBrasileiro.Utils.Id, only: [validate_id: 1]
  import SaborBrasileiro, only: [preload_best_confectioner: 2]
  import SaborBrasileiro.BestConfectioners.Queries, only: [get_best_confectioner_by_id: 2]

  def call(id) do
    case validate_id(id) do
      :ok ->
        Multi.new()
        |> get_best_confectioner_by_id(id)
        |> Multi.run(:delete_confectioner, fn repo, %{get_confectioner: best_confectioner} ->
          repo.delete(best_confectioner)
        end)
        |> preload_best_confectioner(:delete_confectioner)
        |> run_transaction

      error ->
        error
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_best_confectioner_data: best_confectioner}} -> {:ok, best_confectioner}
    end
  end
end
