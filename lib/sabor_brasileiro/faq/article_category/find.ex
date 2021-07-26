defmodule SaborBrasileiro.FAQ.ArticlesCategories.Find do
  alias SaborBrasileiro.FAQ.ArticlesCategories.Queries
  alias SaborBrasileiro.{Repo}
  alias Ecto.{Multi}

  def call(query) do
    Multi.new()
    |> Multi.run(:get_article_categories, fn repo, _ ->
      get_article_categories(repo, query)
    end)
    |> Queries.preload_data(:get_article_categories)
    |> run_transaction
  end

  defp get_article_categories(repo, query) do
    Queries.get_with(query)
    |> repo.all()
    |> handle_article_categories
  end

  defp handle_article_categories(categories), do: {:ok, categories}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_category_data: categories}} -> {:ok, categories}
    end
  end
end
