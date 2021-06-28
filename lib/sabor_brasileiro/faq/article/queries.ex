defmodule SaborBrasileiro.FAQ.Articles.Queries do
  alias Ecto.{Multi}

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_faq_article_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :faq_article_category
       ])}
    end)
  end
end
