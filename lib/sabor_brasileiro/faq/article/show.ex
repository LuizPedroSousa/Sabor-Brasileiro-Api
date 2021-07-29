defmodule SaborBrasileiro.FAQ.Articles.Show do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{FAQArticle, Repo}
  alias SaborBrasileiro.FAQ.Articles.Queries

  def call(slug) do
    Multi.new()
    |> Multi.run(:get_article, fn repo, _ ->
      get_article(repo, slug)
      |> handle_article()
    end)
    |> Queries.preload_data(:get_article)
    |> run_transaction
  end

  defp get_article(repo, slug) do
    Queries.get_with(%{"slug" => slug})
    |> repo.one()
  end

  defp handle_article(article) do
    case article do
      nil -> {:error, "Article not found"}
      %FAQArticle{} = article -> {:ok, article}
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_data: article}} -> {:ok, article}
    end
  end
end
