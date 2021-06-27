defmodule SaborBrasileiroWeb.FAQView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{FAQArticleCategory, FAQArticle}

  def render("create_article_category.json", %{category: category}) do
    %{
      ok: "article category created with successfully",
      category: get_article_category(category)
    }
  end

  def render("find_article_categories.json", %{categories: categories}) do
    %{
      ok: "Get article categories with successfully",
      categories: get_many_article_categories(categories)
    }
  end

  def render("delete_article_categories.json", %{categories: categories}) do
    %{
      ok: "article categories has deleted with successfully",
      categories: get_many_article_categories(categories)
    }
  end

  defp get_many_article_categories(categories) do
    categories
    |> Enum.map(fn category ->
      get_article_category(category)
    end)
  end

  defp get_article_category(%FAQArticleCategory{
         id: id,
         name: name,
         faq_article: articles,
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      articles: get_many_articles(articles),
      name: name,
      inserted_at: inserted_at
    }
  end

  defp get_many_articles(articles) do
    articles
    |> Enum.map(fn article ->
      get_article(article)
    end)
  end

  defp get_article(%FAQArticle{
         id: id,
         title: title,
         description: description,
         slug: slug,
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      title: title,
      description: description,
      slug: slug,
      inserted_at: inserted_at
    }
  end
end
