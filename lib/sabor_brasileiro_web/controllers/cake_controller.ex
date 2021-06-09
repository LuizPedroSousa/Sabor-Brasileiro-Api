defmodule SaborBrasileiroWeb.CakeController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{Cake}
  import SaborBrasileiro, only: [create_cake: 1, get_all_cakes: 0]

  action_fallback SaborBrasileiroWeb.FallbackController

  def index(conn, params) do
    with {:ok, %Cake{} = cake} <- get_all_cakes() do
      conn
      |> put_status(:ok)
      |> render("get.json", cake: cake)
    end
  end

  def create(conn, params) do
    with {:ok, %Cake{} = cake} <- create_cake(params) do
      conn
      |> put_status(:created)
      |> render("create.json", cake: cake)
    end
  end

end
