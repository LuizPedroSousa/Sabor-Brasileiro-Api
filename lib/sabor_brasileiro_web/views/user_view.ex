defmodule SaborBrasileiroWeb.UserView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{User, UserAvatar}

  alias SaborBrasileiro.Users.Auth.ValidateUserOTP.Response,
    as: ValidateUserOTPResponse

  alias SaborBrasileiro.Users.Availables.CheckNickname.Response,
    as: CheckUserNicknameResponse

  def render("create_user.json", %{user: user}) do
    %{
      ok: "user created with successfully",
      user: get_user(user)
    }
  end

  def render("show_user.json", %{user: user}) do
    %{
      ok: "Show user data with successfully",
      user: get_user(user)
    }
  end

  def render("send_authentication_email.json", %{user: %User{} = user}) do
    %{
      ok: "Sended pin code to user email",
      user: %{
        name: user.name,
        email: user.email
      }
    }
  end

  def render("authenticate_user.json", %{
        response: %ValidateUserOTPResponse{user: user, tokens: tokens}
      }) do
    %{
      ok: "User authenticated with successfully",
      user: get_user(user),
      access_token: tokens.access_token,
      refresh_token: tokens.refresh_token
    }
  end

  def render("check_user_nickname.json", %{
        response: %CheckUserNicknameResponse{isNicknameAvailable: isNicknameAvailable}
      }) do
    %{
      isNicknameAvailable: isNicknameAvailable
    }
  end

  defp get_user(
         %User{
           user_avatar: %UserAvatar{} = user_avatar
         } = user
       ) do
    %{
      id: user.id,
      name: user.name,
      surname: user.surname,
      email: user.email,
      nickname: user.nickname,
      avatar: %{
        id: user_avatar.id,
        url: user_avatar.url,
        user_id: user.id,
        inserted_at: user_avatar.inserted_at
      },
      isAdmin: user.isAdmin,
      isConfectioner: user.isConfectioner,
      inserted_at: user.inserted_at
    }
  end
end
