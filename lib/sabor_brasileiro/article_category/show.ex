defmodule SaborBrasileiro.ArticleCategory.Show do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{FAQArticleCategory, Repo}
  alias SaborBrasileiro.ArticleCategory.Queries

  def call(slug) do
    Multi.new()
    |> Multi.run(:get_article_category, fn repo, _ ->
      Queries.get_with(%{"slug" => slug})
      |> repo.one()
      |> case do
        nil -> {:error, "Category not found"}
        %FAQArticleCategory{} = category -> {:ok, category}
      end
    end)
    |> Queries.preload_data(:get_article_category)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_category_data: category}} -> {:ok, category}
    end
  end
end
