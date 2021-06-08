defmodule SaborBrasileiroWeb.UserView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{User, UserAvatar}

  def render("create.json", user) do
    %{
      ok: "user created with successfully",
      user: get_credentials(user)
    }
  end

  defp get_credentials(%{
         user: %User{
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
         }
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
