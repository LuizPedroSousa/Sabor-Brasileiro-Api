defmodule SaborBrasileiroWeb.BestConfectionerView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{BestConfectioner, User}

  def render("create.json", %{best_confectioner: best_confectioner}) do
    %{
      ok: "Best confectioner created with successfully",
      best_confectioner: get_best_confectioner(best_confectioner)
    }
  end

  defp get_best_confectioner(%BestConfectioner{
         id: id,
         user: %User{id: user_id, name: name, email: email, surname: surname},
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      confectioner: %{
        id: user_id,
        name: name,
        email: email,
        surname: surname
      },
      inserted_at: inserted_at
    }
  end
end
