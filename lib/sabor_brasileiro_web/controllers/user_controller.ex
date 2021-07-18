defmodule SaborBrasileiroWeb.UserController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{User}

  action_fallback SaborBrasileiroWeb.FallbackController

  def create_user(conn, params) do
    with {:ok, %User{} = user} <- SaborBrasileiro.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create_user.json", user: user)
    end
  end

  def authenticate_user(conn, params) do
    with {:ok, %User{} = user} <- SaborBrasileiro.authenticate_user(params) do
      conn
      |> put_status(:ok)
      |> render("authenticate_user.json", user: user)
    end
  end
end
