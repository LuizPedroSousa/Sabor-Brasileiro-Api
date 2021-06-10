defmodule SaborBrasileiroWeb.CakeCategoryController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{CakeCategory}
  import SaborBrasileiro, only: [create_cake_category: 1, update_category: 2, delete_category: 1]
  action_fallback SaborBrasileiroWeb.FallbackController

  def create(conn, params) do
    with {:ok, %CakeCategory{} = category} <- create_cake_category(params) do
      conn
      |> put_status(:created)
      |> render("create.json", category: category)
    end
  end

  def update(conn, _params) do
    query = conn.path_params
    body = conn.body_params

    with {:ok, %CakeCategory{} = category} <- update_category(query, body) do
      conn
      |> put_status(:ok)
      |> render("update.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %CakeCategory{} = category} <- delete_category(id) do
      conn
      |> put_status(:ok)
      |> render("delete.json", category: category)
    end
  end
end
