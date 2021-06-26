defmodule SaborBrasileiroWeb.FAQView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{FaqArticleCategory}

  def render("create_article_category.json", %{category: category}) do
    %{
      ok: "article category created with successfully",
      category: get_article_category(category)
    }
  end

  defp get_article_category(%FaqArticleCategory{
         id: id,
         name: name,
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      name: name,
      inserted_at: inserted_at
    }
  end
end
