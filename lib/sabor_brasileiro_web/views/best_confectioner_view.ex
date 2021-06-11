defmodule SaborBrasileiroWeb.BestConfectionerView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{BestConfectioner, User}

  def render("index.json", %{best_confectioners: best_confectioners}) do
    %{
      ok: "Get Best Confectioners with successfully",
      BestConfectioners: get_best_confectioners(best_confectioners)
    }
  end

  def render("create.json", %{best_confectioner: best_confectioner}) do
    %{
      ok: "Best confectioner created with successfully",
      best_confectioner: get_best_confectioner(best_confectioner)
    }
  end

  defp get_best_confectioners(best_confectioners) do
    best_confectioners
    |> Enum.map(fn best_confectioner -> best_confectioner |> get_best_confectioner() end)
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
