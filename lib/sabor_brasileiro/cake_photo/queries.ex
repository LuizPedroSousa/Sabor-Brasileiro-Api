defmodule SaborBrasileiro.CakePhotos.Queries do
  import Ecto.Query
  alias Ecto.Multi
  alias SaborBrasileiro.{CakePhoto}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(cp in CakePhoto)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"order", "desc"}, query) do
    order_by(query, [cp], desc: [cp.inserted_at])
  end

  defp compose_query({"order", "asc"}, query) do
    order_by(query, [cp], asc: [cp.inserted_at])
  end

  defp compose_query({"_limit", limit_c}, query) do
    limit(query, ^limit_c)
  end

  defp compose_query({"ids", ids}, query) do
    query
    |> where([cp, c], cp.id in ^ids)
  end

  defp compose_query({"id", id}, query) do
    query
    |> where([cp, _c], cp.id == ^id)
  end

  defp compose_query({"cake_id", cake_id}, query) do
    query
    |> where([cp], cp.cake_id in ^cake_id)
  end

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_cake_photo_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :cake
       ])}
    end)
  end
end
