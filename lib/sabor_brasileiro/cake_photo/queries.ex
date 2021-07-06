defmodule SaborBrasileiro.CakePhotos.Queries do
  import Ecto.Query
  alias SaborBrasileiro.{CakePhoto}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query do
    from(cp in CakePhoto,
      order_by: [desc: cp.inserted_at]
    )
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"ids", ids}, query) do
    query
    |> where([cp, c], cp.id in ^ids)
  end

  defp compose_query({"cake_id", cake_id}, query) do
    query
    |> where([cp], cp.cake_id in ^[cake_id])
  end

  defp compose_query(_unsupported_param, query) do
    query
  end
end