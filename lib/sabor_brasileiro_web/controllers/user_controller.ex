defmodule SaborBrasileiroWeb.UserController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{User}
  import SaborBrasileiro, only: [create_user: 1]

  action_fallback SaborBrasileiroWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
