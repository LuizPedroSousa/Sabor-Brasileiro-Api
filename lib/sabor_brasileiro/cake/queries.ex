defmodule SaborBrasileiro.Cakes.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake, CakePhoto}
  import SaborBrasileiro.Utils.Id, only: [validate_ids: 1]

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

  def get_cakes_with(multi, query) do
    multi
    |> Multi.run(:get_cakes, fn repo, _ ->
      like_category = "%#{query["category"]}%"
      like_name = "%#{query["name"]}%"

      query =
        case is_nil(query["stars"]) do
          true ->
            from(c in Cake,
              join: cc in "cake_category",
              on: c.cake_category_id == cc.id and ilike(cc.name, ^like_category),
              where: ilike(c.name, ^like_name),
              limit: ^query["_limit"],
              order_by: [desc: c.inserted_at]
            )

          false ->
            from(c in Cake,
              join: cc in "cake_category",
              on: c.cake_category_id == cc.id and ilike(cc.name, ^like_category),
              where: ilike(c.name, ^like_name) and c.stars >= ^query["stars"],
              order_by: [desc: c.inserted_at]
            )
        end

      {:ok, repo.all(query)}
    end)
    |> preload_data(:get_cakes)
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

  def get_cake_by_slug(multi, slug) do
    multi
    |> Multi.run(:get_cake, fn repo, _ ->
      from(c in Cake,
        where: ilike(c.slug, ^slug),
        order_by: [desc: c.inserted_at]
      )
      |> repo.one()
      |> case do
        nil -> {:error, "Cake not found"}
        %Cake{} = cake -> {:ok, cake}
      end
    end)
    |> preload_data(:get_cake)
  end

  def delete_with_ids(multi, ids) do
    multi
    |> Multi.run(:get_cakes, fn repo, _ ->
      case validate_ids(ids) do
        :ok ->
          from(c in Cake,
            where: c.id in ^ids
          )
          |> repo.all()
          |> case do
            [] -> {:error, "Cakes not found"}
            cakes -> {:ok, cakes}
          end

        error ->
          error
      end
    end)
    |> preload_data(:get_cakes)
    |> Multi.delete_all(:delete_photos, fn _ ->
      from(p in CakePhoto,
        where: p.cake_id in ^ids
      )
    end)
    |> Multi.delete_all(:delete_cake, fn _ ->
      from(c in Cake,
        where: c.id in ^ids
      )
    end)
  end
end
