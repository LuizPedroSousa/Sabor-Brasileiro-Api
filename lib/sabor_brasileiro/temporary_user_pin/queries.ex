defmodule SaborBrasileiro.TemporaryUserPin.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{TemporaryUserPin}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(t in TemporaryUserPin)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"order", "desc"}, query) do
    order_by(query, [cc], desc: [cc.inserted_at])
  end

  defp compose_query({"order", "asc"}, query) do
    order_by(query, [cc], asc: [cc.inserted_at])
  end

  defp compose_query({"_limit", limit_c}, query) do
    limit(query, ^limit_c)
  end

  defp compose_query({"user_id", user_id}, query) do
    where(query, [t], t.user_id == ^user_id)
  end
end
