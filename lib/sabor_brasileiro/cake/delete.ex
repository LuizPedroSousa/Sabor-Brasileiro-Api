defmodule SaborBrasileiro.Cakes.Delete do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, Cakes.Queries, CakePhotos}
  import Ecto.Query

  def call(ids) do
    id_list =
      ids
      |> String.split(",")

    Multi.new()
    |> Multi.run(:get_cakes, fn repo, _ ->
      get_cakes(repo, id_list)
    end)
    |> Queries.preload_data(:get_cakes)
    |> Multi.delete_all(:delete_photos, fn _ ->
      CakePhotos.Queries.get_with(%{"cake_id" => id_list})
    end)
    |> Multi.delete_all(:delete_cake, fn _ ->
      Queries.get_with(%{"ids" => id_list})
    end)
    |> run_transaction
  end

  defp get_cakes(repo, id_list) do
    Queries.get_with(%{"ids" => id_list})
    |> repo.all()
    |> handle_cakes()
  end

  defp handle_cakes([]), do: {:error, "Cakes not found"}
  defp handle_cakes(cakes), do: {:ok, cakes}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cakes}} -> {:ok, cakes}
    end
  end
end
