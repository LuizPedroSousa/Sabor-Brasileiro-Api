defmodule SaborBrasileiro.BestConfectioners.Delete do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, BestConfectioners.Queries}
  import SaborBrasileiro.Utils.Id, only: [validate_id: 1]

  def call(id) do
    case validate_id(id) do
      :ok ->
        Multi.new()
        |> Queries.get_best_confectioner_by_id(id)
        |> Multi.run(:delete_confectioner, fn repo, %{get_confectioner: best_confectioner} ->
          repo.delete(best_confectioner)
        end)
        |> Queries.preload_data(:delete_confectioner)
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
