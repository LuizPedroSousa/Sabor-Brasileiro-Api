defmodule SaborBrasileiro.CakeCategories.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{CakeCategory}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(cc in CakeCategory)
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

  defp compose_query({"name", name}, query) do
    name_like = "%#{name}%"
    where(query, [cc], ilike(cc.name, ^name_like))
  end

  defp compose_query({"slug", slug}, query) do
    where(query, [cc], cc.slug == ^slug)
  end

  defp compose_query({"id", id}, query) do
    where(query, [cc], cc.id == ^id)
  end

  defp compose_query({"ids", ids}, query) do
    where(query, [cc], cc.id in ^ids)
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_cake_category_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :cake
       ])}
    end)
  end
end
