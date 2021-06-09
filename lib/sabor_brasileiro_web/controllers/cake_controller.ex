defmodule SaborBrasileiroWeb.CakeController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{Cake}
  import SaborBrasileiro, only: [create_cake: 1]

  action_fallback SaborBrasileiroWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Cake{} = cake} <- create_cake(params) do
      conn
      |> put_status(:created)
      |> render("create.json", cake: cake)
    end
  end
end
