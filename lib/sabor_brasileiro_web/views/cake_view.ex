defmodule SaborBrasileiroWeb.CakeView do
  use SaborBrasileiroWeb, :view
  alias SaborBrasileiro.{Cake, CakePhoto, CakeCategory}

  def render("create.json", cake) do
    %{
      ok: "cake created with successfully",
      cake: get_credentials(cake)
    }
  end

  defp get_credentials(%{
         cake: %Cake{
           id: id,
           name: name,
           description: description,
           price: price,
           slug: slug,
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
      photos: format_photos(cake_photos),
      price: price,
      slug: slug,
      stars: stars,
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
