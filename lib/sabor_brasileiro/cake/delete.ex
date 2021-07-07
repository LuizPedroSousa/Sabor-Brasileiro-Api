defmodule SaborBrasileiro.Cakes.Delete do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, Cake, Cakes.Queries, CakePhoto}
  import SaborBrasileiro.Utils.Id, only: [validate_ids: 1]
  import Ecto.Query

  def call(ids) do
    id_list =
      ids
      |> String.split(",")

    case validate_ids(id_list) do
      :ok ->
        Multi.new()
        |> Multi.run(:get_cakes, fn repo, _ ->
          get_cakes(repo, id_list)
        end)
        |> Queries.preload_data(:get_cakes)
        |> Multi.delete_all(:delete_photos, fn _ ->
          from(p in CakePhoto,
            where: p.cake_id in ^id_list
          )
        end)
        |> Multi.delete_all(:delete_cake, fn _ ->
          from(c in Cake,
            where: c.id in ^id_list
          )
        end)
        |> run_transaction

      error ->
        error
    end
  end

  defp get_cakes(repo, id_list) do
    Queries.get_with(%{"ids" => id_list})
    |> repo.all()
    |> handle_cake()
  end

  defp handle_cake(cakes) do
    case cakes do
      [] -> {:error, "Cakes not found"}
      _cakes -> {:ok, cakes}
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cakes}} -> {:ok, cakes}
    end
  end
end
