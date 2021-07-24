defmodule SaborBrasileiro.CakeRatings.Queries do
  alias Ecto.Multi
  alias SaborBrasileiro.{CakeRating}
  import Ecto.Query

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(cr in CakeRating)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"order", "desc"}, query) do
    order_by(query, [cr], desc: [cr.inserted_at])
  end

  defp compose_query({"order", "asc"}, query) do
    order_by(query, [cr], asc: [cr.inserted_at])
  end

  defp compose_query({"_limit", limit_c}, query) do
    limit(query, ^limit_c)
  end

  defp compose_query({"title", title}, query) do
    title_like = "%#{title}%"
    where(query, [cr], ilike(cr.title, ^title_like))
  end

  defp compose_query({"stars", stars}, query) do
    where(query, [cr], cr.stars >= ^stars)
  end

  defp compose_query({"cake_id", cake_id}, query) do
    where(query, [cr], cr.cake_id == ^cake_id)
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_cake_rating_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :cake,
         :user,
         user: :user_avatar,
         cake: :cake_category
       ])}
    end)
  end
end
