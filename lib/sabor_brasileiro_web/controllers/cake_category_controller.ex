defmodule SaborBrasileiroWeb.CakeCategoryController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{CakeCategory}
  import SaborBrasileiro, only: [create_cake_category: 1]

  def create(conn, params) do
    with {:ok, %CakeCategory{} = category} <- create_cake_category(params) do
      conn
      |> put_status(:created)
      |> render("create.json", category: category)
    end
  end
end
