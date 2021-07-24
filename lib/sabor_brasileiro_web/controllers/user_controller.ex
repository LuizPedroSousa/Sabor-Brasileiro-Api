defmodule SaborBrasileiroWeb.UserController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{User, TemporaryUserPin}

  alias SaborBrasileiro.Users.Auth.ValidateUserPin.Response,
    as: ValidateUserPinResponse

  action_fallback(SaborBrasileiroWeb.FallbackController)

  def create_user(conn, params) do
    with {:ok, %User{} = user} <- SaborBrasileiro.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create_user.json", user: user)
    end
  end

  def show_user(conn, _params) do
    with {:ok, %User{} = user} <- SaborBrasileiro.show_user(conn.assigns) do
      conn
      |> put_status(:ok)
      |> render("show_user.json", user: user)
    end
  end

  def auth_user_credentials(conn, params) do
    with {:ok, %User{} = user, %TemporaryUserPin{} = pin} <-
           SaborBrasileiro.auth_user_credentials(params) do
      with :ok <- SaborBrasileiro.Email.send_auth_pin(user, pin, conn) do
        conn
        |> put_status(:ok)
        |> render("send_authentication_email.json", user: user)
      end
    end
  end

  def auth_user_pin(conn, params) do
    with {:ok, %ValidateUserPinResponse{} = response} <- SaborBrasileiro.validate_user_pin(params) do
      conn
      |> put_status(:ok)
      |> render("authenticate_user.json", response: response)
    end
  end
end
