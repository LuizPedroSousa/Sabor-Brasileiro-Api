defmodule SaborBrasileiro.FAQ.ArticlesCategories.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{FAQArticleCategory}

  def get_with(query) do
    base_query(query)
    |> build_query(query)
  end

  defp base_query(query) do
    from(ac in FAQArticleCategory,
      order_by: [desc: ac.inserted_at],
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

  defp compose_query({"ids", ids}, query) do
    where(query, [ac], ac.id in ^ids)
  end

  defp compose_query({"slug", slug}, query) do
    where(query, [ac], ac.slug == ^slug)
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_faq_article_category_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :faq_article
       ])}
    end)
  end
end
