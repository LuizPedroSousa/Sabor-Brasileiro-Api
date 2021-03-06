defmodule SaborBrasileiro.Cakes.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(c in Cake)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"order", "desc"}, query) do
    order_by(query, [c], desc: [c.inserted_at])
  end

  defp compose_query({"order", "asc"}, query) do
    order_by(query, [c], asc: [c.inserted_at])
  end

  defp compose_query({"_limit", limit_c}, query) do
    limit(query, ^limit_c)
  end

  defp compose_query({"name", name}, query) do
    name_like = "%#{name}%"
    where(query, [c], ilike(c.name, ^name_like))
  end

  defp compose_query({"category_slug", category_slug}, query) do
    like_category_slug = "%#{category_slug}%"

    query
    |> join(:left, [c], cc in assoc(c, :cake_category))
    |> where([_c, cc], ilike(cc.slug, ^like_category_slug))
  end

  defp compose_query({"category_name", category_name}, query) do
    like_category_name = "%#{category_name}%"

    query
    |> join(:left, [c], cc in assoc(c, :cake_category))
    |> where([_c, cc], ilike(cc.name, ^like_category_name))
  end

  defp compose_query({"id", id}, query) do
    where(query, [c], c.id == ^id)
  end

  defp compose_query({"ids", ids}, query) do
    where(query, [c], c.id in ^ids)
  end

  defp compose_query({"slug", slug}, query) do
    where(query, [c], c.slug == ^slug)
  end

  defp compose_query({"price", price}, query) do
    case(String.contains?(price, ",")) do
      true ->
        [from, to] = price |> String.split(",")
        where(query, [c], c.price > ^from and c.price <= ^to)

      false ->
        where(query, [c], c.price >= ^price)
    end
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_cake_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :cake_photos,
         :cake_ingredients,
         :cake_category,
         :cake_ratings,
         cake_ratings: [:cake, :user, user: :user_avatar]
       ])}
    end)
  end
end
