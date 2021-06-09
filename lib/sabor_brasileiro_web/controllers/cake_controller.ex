defmodule SaborBrasileiroWeb.CakeController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{Cake}
  import SaborBrasileiro, only: [create_cake: 1, get_all_cakes: 0, update_cake: 2]

  action_fallback SaborBrasileiroWeb.FallbackController

  def index(conn, _params) do
    with {:ok, cakes} <- get_all_cakes() do
      conn
      |> put_status(:ok)
      |> render("get_all.json", cakes: cakes)
    end
  end

  def create(conn, params) do
    with {:ok, %Cake{} = cake} <- create_cake(params) do
      conn
      |> put_status(:created)
      |> render("create.json", cake: cake)
    end
  end

  def update(conn, params) do
    %{"id" => id} = params
    body = params |> Map.delete("id")

    with {:ok, %Cake{} = cake} <- update_cake(id, body) do
      conn
      |> put_status(:ok)
      |> render("update.json", cake: cake)
    end
  end
end
