defmodule SaborBrasileiro.FAQ.Articles.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, FAQArticleCategory, FAQArticle}
  alias SaborBrasileiro.FAQ.Articles.Queries
  alias SaborBrasileiro.FAQ.ArticlesCategories

  def call(params) do
    Multi.new()
    |> Multi.run(:get_category, fn repo, _ ->
      get_category(repo, params["category"])
    end)
    |> Multi.insert(:create_article, fn %{get_category: %FAQArticleCategory{id: category_id}} ->
      article_changeset(params, category_id)
    end)
    |> Queries.preload_data(:create_article)
    |> run_transaction
  end

  defp get_category(repo, name) do
    ArticlesCategories.Queries.get_with(%{"name" => name})
    |> repo.one()
    |> case do
      nil -> {:error, "Category not found"}
      %FAQArticleCategory{} = category -> {:ok, category}
    end
  end

  defp article_changeset(params, category_id) do
    Map.merge(params, %{"faq_article_category_id" => category_id})
    |> FAQArticle.changeset()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_data: article}} -> {:ok, article}
    end
  end
end
