defmodule SaborBrasileiro.CakeIngredients.Queries do
  import Ecto.Query
  alias SaborBrasileiro.{CakeIngredient}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query do
    from(ci in CakeIngredient,
      order_by: [desc: ci.inserted_at]
    )
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"cake_id", cake_id}, query) do
    query
    |> where([ci], ci.cake_id in ^[cake_id])
  end
end
