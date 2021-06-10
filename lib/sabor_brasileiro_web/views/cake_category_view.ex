defmodule SaborBrasileiroWeb.CakeCategoryView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{CakeCategory}

  def render("create.json", category) do
    %{
      ok: "category created with successfully",
      category: get_category(category)
    }
  end

  def render("get_all.json", %{categories: categories}) do
    %{
      ok: "Get categories with successfully",
      categories: get_many_categories(categories)
    }
  end

  def render("update.json", category) do
    %{
      ok: "category updated with successfully",
      category: get_category(category)
    }
  end

  def render("delete.json", category) do
    %{
      ok: "category deleted with successfully",
      category: get_category(category)
    }
  end

  defp get_many_categories(categories) do
    categories
    |> Enum.map(fn cake ->
      get_category(%{cake: cake})
    end)
  end

  defp get_category(%{
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
