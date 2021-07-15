defmodule SaborBrasileiroWeb.CakeController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{Cake, CakePhoto, CakeCategory}

  action_fallback SaborBrasileiroWeb.FallbackController

  def find_cakes(conn, _params) do
    query = conn.query_params

    with {:ok, cakes} <- SaborBrasileiro.get_cakes(query) do
      conn
      |> put_status(:ok)
      |> render("find_cakes.json", cakes: cakes)
    end
  end

  def find_cake_categories(conn, _params) do
    with {:ok, categories} <- SaborBrasileiro.get_categories(conn.query_params) do
      conn
      |> put_status(:ok)
      |> render("find_cake_categories.json", categories: categories)
    end
  end

  def show_cake(conn, %{"slug" => slug}) do
    with {:ok, %Cake{} = cake} <- SaborBrasileiro.show_cake(slug) do
      conn
      |> put_status(:ok)
      |> render("show_cake.json", cake: cake)
    end
  end

  def create_cake(conn, params) do
    with {:ok, %Cake{} = cake} <- SaborBrasileiro.create_cake(params) do
      conn
      |> put_status(:created)
      |> render("create_cake.json", cake: cake)
    end
  end

  def create_cake_category(conn, params) do
    with {:ok, %CakeCategory{} = category} <- SaborBrasileiro.create_cake_category(params) do
      conn
      |> put_status(:created)
      |> render("create_cake_category.json", category: category)
    end
  end

  def update_cake(conn, _params) do
    %{"slug" => slug} = conn.path_params

    with {:ok, %Cake{} = cake} <- SaborBrasileiro.update_cake(slug, conn.body_params) do
      conn
      |> put_status(:ok)
      |> render("update_cake.json", cake: cake)
    end
  end

  def update_cake_category(conn, _params) do
    query = conn.path_params
    body = conn.body_params

    with {:ok, %CakeCategory{} = category} <- SaborBrasileiro.update_category(query, body) do
      conn
      |> put_status(:ok)
      |> render("update_cake_category.json", category: category)
    end
  end

  def update_cake_photo(conn, _params) do
    %{"id" => id} = conn.path_params

    with {:ok, %CakePhoto{} = cake_photo} <-
           SaborBrasileiro.update_cake_photo(id, conn.body_params) do
      conn
      |> put_status(:ok)
      |> render("update_cake_photo.json", cake_photo: cake_photo)
    end
  end

  def delete_cake(conn, %{"id" => id}) do
    with {:ok, cakes} <- SaborBrasileiro.delete_cake(id) do
      conn
      |> put_status(:ok)
      |> render("delete_cake.json", cakes: cakes)
    end
  end

  def delete_cake_category(conn, %{"id" => id}) do
    with {:ok, %CakeCategory{} = category} <- SaborBrasileiro.delete_category(id) do
      conn
      |> put_status(:ok)
      |> render("delete_cake_category.json", category: category)
    end
  end
end
