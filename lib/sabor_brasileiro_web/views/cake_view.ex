defmodule SaborBrasileiroWeb.CakeView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{Cake, CakePhoto, CakeCategory}

  def render("create.json", cake) do
    %{
      ok: "cake created with successfully",
      cake: get_cake(cake)
    }
  end

  def render("index.json", %{cakes: cakes}) do
    %{
      ok: "Get all cakes with successfully",
      cakes: get_many_cakes(cakes)
    }
  end

  def render("update.json", cake) do
    %{
      ok: "cake updated with successfully",
      cake: get_cake(cake)
    }
  end

  defp get_many_cakes(cakes) do
    cakes
    |> Enum.map(fn cake ->
      get_cake(%{cake: cake})
    end)
  end

  defp get_cake(%{
         cake: %Cake{
           id: id,
           name: name,
           description: description,
           price: price,
           slug: slug,
           is_best: is_best,
           stars: stars,
           cake_category: %CakeCategory{
             name: category_name
           },
           cake_photos: cake_photos,
           inserted_at: inserted_at
         }
       }) do
    %{
      id: id,
      name: name,
      description: description,
      isBest: is_best,
      photos: format_photos(cake_photos),
      slug: slug,
      stars: stars,
      price: price,
      category: category_name,
      inserted_at: inserted_at
    }
  end

  defp format_photos(photos) do
    photos
    |> Enum.map(fn %CakePhoto{id: id, url: url, cake_id: cake_id, inserted_at: inserted_at} ->
      %{id: id, url: url, inserted_at: inserted_at, cake: cake_id}
    end)
  end
end
