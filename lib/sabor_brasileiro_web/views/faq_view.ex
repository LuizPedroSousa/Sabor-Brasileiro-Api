defmodule SaborBrasileiroWeb.FAQView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{FAQArticleCategory, FAQArticle, FAQSolicitation}

  def render("create_article_category.json", %{category: category}) do
    %{
      ok: "article category created with successfully",
      category: get_article_category(category)
    }
  end

  def render("create_article.json", %{article: article}) do
    %{
      ok: "article created with successfully",
      article: get_article(article)
    }
  end

  def render("create_solicitation.json", %{solicitation: solicitation}) do
    %{
      ok: "solicitation created with successfully",
      solicitation: get_solicitation(solicitation)
    }
  end

  def render("find_article_categories.json", %{categories: categories}) do
    %{
      ok: "Get article categories with successfully",
      categories: get_many_article_categories(categories)
    }
  end

  def render("find_articles.json", %{articles: articles}) do
    %{
      ok: "Get articles with successfully",
      articles: get_many_articles(articles)
    }
  end

  def render("show_article_category.json", %{category: category}) do
    %{
      ok: "Show article category with successfully",
      category: get_article_category(category)
    }
  end

  def render("show_article.json", %{article: article}) do
    %{
      ok: "Show article with successfully",
      article: get_article(article)
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
         slug: slug,
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      articles: get_many_articles(articles),
      name: name,
      slug: slug,
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
         faq_article_category: %FAQArticleCategory{
           name: category_name
         },
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      title: title,
      category: category_name,
      description: description,
      slug: slug,
      inserted_at: inserted_at
    }
  end

  defp get_solicitation(%FAQSolicitation{
         id: id,
         name: name,
         email: email,
         reason: reason,
         surname: surname,
         description: description
       }) do
    %{
      id: id,
      name: name,
      email: email,
      reason: reason,
      surname: surname,
      description: description
    }
  end
end
