defmodule SaborBrasileiro.FAQ.ArticlesCategories.Delete do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, FAQArticle, FAQArticleCategory}
  alias SaborBrasileiro.FAQ.ArticlesCategories.Queries
  import SaborBrasileiro.Utils.Id, only: [validate_ids: 1]

  def call(ids) do
    id_list = ids |> String.split(",")

    Multi.new()
    |> Multi.run(:get_article_categories, fn repo, _ ->
      case validate_ids(id_list) do
        :ok ->
          Queries.get_with(%{"ids" => id_list})
          |> repo.all()
          |> case do
            [] -> {:error, "Category not found"}
            categories -> {:ok, categories}
          end

        error ->
          error
      end
    end)
    |> Queries.preload_data(:get_article_categories)
    |> Multi.delete_all(:delete_articles, fn _ ->
      from(a in FAQArticle,
        where: a.faq_article_category_id in ^id_list
      )
    end)
    |> Multi.delete_all(:delete_article_categories, fn _ ->
      from(ac in FAQArticleCategory,
        where: ac.id in ^id_list
      )
    end)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_category_data: categories}} -> {:ok, categories}
    end
  end
end
