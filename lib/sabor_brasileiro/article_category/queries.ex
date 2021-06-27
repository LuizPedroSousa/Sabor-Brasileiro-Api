defmodule SaborBrasileiro.ArticleCategory.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{FAQArticleCategory}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query do
    from(ac in FAQArticleCategory)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"name", name}, query) do
    name_like = "%#{name}%"
    where(query, [ac], ilike(ac.name, ^name_like))
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