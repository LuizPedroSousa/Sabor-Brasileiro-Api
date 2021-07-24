defmodule SaborBrasileiroWeb.UserRoleView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{User, UserAvatar}

  def render("create_best_confectioner.json", %{user: user}) do
    %{
      ok: "Best Confectioner created with successfully",
      confectioner: get_confectioner(user)
    }
  end

  def render("find_best_confectioners.json", %{best_confectioners: best_confectioners}) do
    %{
      ok: "Best Confectioner created with successfully",
      confectioners: get_confectioners(best_confectioners)
    }
  end

  def render("delete_best_confectioner.json", %{user: user}) do
  end

  defp get_confectioners(best_confectioners) do
    best_confectioners
    |> Enum.map(fn %User{} = user -> get_confectioner(user) end)
  end

  defp get_confectioner(%User{
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
