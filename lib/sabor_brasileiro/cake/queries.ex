defmodule SaborBrasileiro.Cakes.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake}

  def get_with(query) do
    base_query(query)
    |> build_query(query)
  end

  defp base_query(query) do
    from(c in Cake,
      order_by: [desc: c.inserted_at],
      limit: ^query["_limit"]
    )
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"name", name}, query) do
    name_like = "%#{name}%"
    where(query, [ac], ilike(ac.name, ^name_like))
  end

  defp compose_query({"category", category_slug}, query) do
    like_category_slug = "%#{category_slug}%"

    query
    |> join(:left, [c], cc in assoc(c, :cake_category))
    |> where([_c, cc], ilike(cc.slug, ^like_category_slug))
  end

  defp compose_query({"ids", ids}, query) do
    where(query, [c], c.id in ^ids)
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
         :cake_category
       ])}
    end)
  end

  def get_cake_by_id(multi, id) do
    multi
    |> Multi.run(:get_cake, fn repo, _ ->
      from(c in Cake,
        where: c.id == ^id
      )
      |> repo.one
      |> case do
        nil -> {:error, "Cake not found"}
        %Cake{} = cake -> {:ok, cake}
      end
    end)
    |> preload_data(:get_cake)
  end

  def get_by_slug(slug) do
    from(c in Cake)
    |> where([c], c.slug == ^slug)
  end
end
