defmodule SaborBrasileiroWeb.UserView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{User, UserAvatar}

  alias SaborBrasileiro.Users.Auth.ValidateUserPin.Response,
    as: ValidateUserPinResponse

  def render("create_user.json", %{user: user}) do
    %{
      ok: "user created with successfully",
      user: get_user(user)
    }
  end

  def render("send_authentication_email.json", _) do
    %{
      ok: "Sended pin code to user email"
    }
  end

  def render("authenticate_user.json", %{
        response: %ValidateUserPinResponse{user: user, tokens: tokens}
      }) do
    %{
      ok: "User authenticated with successfully",
      user: get_user(user),
      access_token: tokens.access_token,
      refresh_token: tokens.refresh_token
    }
  end

  defp get_user(%User{
         id: id,
         name: name,
         surname: surname,
         email: email,
         nickname: nickname,
         user_avatar: %UserAvatar{
           id: avatar_id,
           url: url,
           user_id: user_id,
           inserted_at: photo_inserted_at
         },
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      name: name,
      surname: surname,
      email: email,
      nickname: nickname,
      avatar: %{
        id: avatar_id,
        url: url,
        user_id: user_id,
        inserted_at: photo_inserted_at
      },
      inserted_at: inserted_at
    }
  end
end
