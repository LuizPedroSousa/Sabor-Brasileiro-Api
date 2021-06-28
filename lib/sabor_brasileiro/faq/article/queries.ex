defmodule SaborBrasileiro.FAQ.Articles.Queries do
  alias Ecto.{Multi}

  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{FAQArticle}

  def get_with(query) do
    base_query(query)
    |> build_query(query)
  end

  defp base_query(query) do
    from(a in FAQArticle,
      order_by: [desc: a.inserted_at],
      limit: ^query["_limit"]
    )
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"title", title}, query) do
    title_like = "%#{title}%"
    where(query, [a], ilike(a.title, ^title_like))
  end

  defp compose_query({"ids", ids}, query) do
    where(query, [a], a.id in ^ids)
  end

  defp compose_query({"slug", slug}, query) do
    where(query, [a], a.slug == ^slug)
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_faq_article_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :faq_article_category
       ])}
    end)
  end
end
