defmodule SaborBrasileiroWeb.UserController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{User}

  alias SaborBrasileiro.Users.Auth.ValidateUserOTP.Response,
    as: ValidateUserOTPResponse

  alias SaborBrasileiro.Users.Availables.CheckNickname.Response,
    as: CheckUserNicknameResponse

  alias SaborBrasileiro.Users.Auth.ValidateCredentials.Response,
    as: ValidateUserCredentialsResponse

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
    with {:ok, %ValidateUserCredentialsResponse{user: user, user_otp: otp}} <-
           SaborBrasileiro.auth_user_credentials(params) do
      with :ok <- SaborBrasileiro.Email.send_auth_pin(user, otp, conn) do
        conn
        |> put_status(:ok)
        |> render("send_authentication_email.json", user: user)
      end
    end
  end

  def auth_user_otp(conn, params) do
    with {:ok, %ValidateUserOTPResponse{} = response} <- SaborBrasileiro.validate_user_otp(params) do
      conn
      |> put_status(:ok)
      |> render("authenticate_user.json", response: response)
    end
  end

  def check_available_user_nickname(conn, params) do
    with {:ok, %CheckUserNicknameResponse{} = response} <-
           SaborBrasileiro.check_user_nickname_available(params) do
      conn
      |> put_status(:ok)
      |> render("check_user_nickname.json", response: response)
    end
  end
end
