defmodule SaborBrasileiro.ArticleCategory.Find do
  alias SaborBrasileiro.ArticleCategory.Queries
  alias SaborBrasileiro.{Repo}
  alias Ecto.{Multi}

  def call(query_params) do
    Multi.new()
    |> Multi.run(:get_article_category, fn repo, _ ->
      Queries.get_with(query_params)
      |> repo.all()
      |> case do
        [] -> {:error, "Category not found"}
        categories -> {:ok, categories}
      end
    end)
    |> Queries.preload_data(:get_article_category)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_category_data: categories}} -> {:ok, categories}
    end
  end
end
