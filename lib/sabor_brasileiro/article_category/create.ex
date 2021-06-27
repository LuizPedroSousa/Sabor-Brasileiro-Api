defmodule SaborBrasileiro.ArticleCategory.Create do
  alias SaborBrasileiro.{Repo, FAQArticleCategory}

  def call(params) do
    params
    |> FAQArticleCategory.changeset()
    |> Repo.insert()
  end
end
