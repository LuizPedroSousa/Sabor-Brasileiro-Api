defmodule SaborBrasileiroWeb.FAQController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{FaqArticleCategory}

  action_fallback SaborBrasileiroWeb.FallbackController

  def create_article_category(conn, params) do
    with {:ok, %FaqArticleCategory{} = category} <-
           SaborBrasileiro.create_article_category(params) do
      conn
      |> put_status(:created)
      |> render("create_article_category.json", category: category)
    end
  end
end
