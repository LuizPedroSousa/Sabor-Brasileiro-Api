defmodule SaborBrasileiro.ArticleCategory.Create do
  alias SaborBrasileiro.{Repo, FaqArticleCategory}

  def call(params) do
    params
    |> FaqArticleCategory.changeset()
    |> Repo.insert()
  end
end
