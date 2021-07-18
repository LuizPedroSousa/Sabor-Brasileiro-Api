defmodule SaborBrasileiroWeb.UserView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{User, UserAvatar}

  def render("create_user.json", %{user: user}) do
    %{
      ok: "user created with successfully",
      user: get_user(user)
    }
  end

  def render("authenticate_user.json", %{user: user}) do
    %{
      ok: "User authenticated with successfully",
      user: get_user(user)
    }
  end

  defp get_user(%User{
         id: id,
         name: name,
         surname: surname,
         email: email,
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
