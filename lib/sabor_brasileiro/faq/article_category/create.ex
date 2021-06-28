defmodule SaborBrasileiro.FAQ.ArticlesCategories.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, FAQArticleCategory}
  alias SaborBrasileiro.FAQ.ArticlesCategories.Queries

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_article_category, fn _ ->
      FAQArticleCategory.changeset(params)
    end)
    |> Queries.preload_data(:create_article_category)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_category_data: category}} -> {:ok, category}
    end
  end
end
