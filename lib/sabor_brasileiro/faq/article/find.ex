defmodule SaborBrasileiro.FAQ.Articles.Find do
  alias SaborBrasileiro.FAQ.Articles.Queries
  alias SaborBrasileiro.{Repo}
  alias Ecto.{Multi}

  def call(query_params) do
    Multi.new()
    |> Multi.run(:get_articles, fn repo, _ ->
      get_articles(repo, query_params)
    end)
    |> Queries.preload_data(:get_articles)
    |> run_transaction
  end

  defp get_articles(repo, query_params) do
    Queries.get_with(query_params)
    |> repo.all()
    |> handle_articles
  end

  defp handle_articles(articles), do: {:ok, articles}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_faq_article_data: articles}} -> {:ok, articles}
    end
  end
end
