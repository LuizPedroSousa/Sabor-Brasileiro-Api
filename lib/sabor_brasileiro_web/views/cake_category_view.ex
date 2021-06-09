defmodule SaborBrasileiroWeb.CakeCategoryView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{CakeCategory}

  def render("create.json", cake) do
    %{
      ok: "cake created with successfully",
      category: get_credentials(cake)
    }
  end

  defp get_credentials(%{
         category: %CakeCategory{
           id: id,
           name: name,
           inserted_at: inserted_at
         }
       }) do
    %{
      id: id,
      name: name,
      inserted_at: inserted_at
    }
  end
end
