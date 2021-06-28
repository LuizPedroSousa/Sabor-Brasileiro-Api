defmodule SaborBrasileiroWeb.FAQController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{FAQArticleCategory, FAQArticle}

  action_fallback SaborBrasileiroWeb.FallbackController

  def create_article_category(conn, params) do
    with {:ok, %FAQArticleCategory{} = category} <-
           SaborBrasileiro.create_article_category(params) do
      conn
      |> put_status(:created)
      |> render("create_article_category.json", category: category)
    end
  end

  def create_article(conn, params) do
    with {:ok, %FAQArticle{} = article} <-
           SaborBrasileiro.create_article(params) do
      conn
      |> put_status(:created)
      |> render("create_article.json", article: article)
    end
  end

  def show_article_category(conn, %{"slug" => slug}) do
    with {:ok, %FAQArticleCategory{} = category} <-
           SaborBrasileiro.show_article_category(slug) do
      conn
      |> put_status(:ok)
      |> render("show_article_category.json", category: category)
    end
  end

  def find_article_categories(conn, _params) do
    with {:ok, categories} <-
           SaborBrasileiro.find_article_category(conn.query_params) do
      conn
      |> put_status(:ok)
      |> render("find_article_categories.json", categories: categories)
    end
  end

  def find_articles(conn, _params) do
    with {:ok, articles} <-
           SaborBrasileiro.find_article(conn.query_params) do
      conn
      |> put_status(:ok)
      |> render("find_articles.json", articles: articles)
    end
  end

  def delete_article_categories(conn, %{"ids" => ids}) do
    with {:ok, categories} <-
           SaborBrasileiro.delete_article_categories(ids) do
      conn
      |> put_status(:ok)
      |> render("delete_article_categories.json", categories: categories)
    end
  end
end
