defmodule SaborBrasileiroWeb.CakeView do
  use SaborBrasileiroWeb, :view

  alias SaborBrasileiro.{
    Cake,
    CakePhoto,
    CakeCategory,
    CakeIngredient,
    CakeRating,
    User,
    UserAvatar
  }

  def render("find_cakes.json", %{cakes: cakes}) do
    %{
      ok: "Get all cakes with successfully",
      cakes: get_many_cakes(cakes)
    }
  end

  def render("find_cake_categories.json", %{categories: categories}) do
    %{
      ok: "Get categories with successfully",
      categories: get_many_categories(categories)
    }
  end

  def render("find_cake_ratings.json", %{cake_ratings: cake_ratings}) do
    %{
      ok: "Get Cake avaliations with successfully",
      ratings: get_cake_ratings(cake_ratings)
    }
  end

  def render("create_cake_category.json", category) do
    %{
      ok: "category created with successfully",
      category: get_category(category)
    }
  end

  def render("create_cake.json", cake) do
    %{
      ok: "Cake created with successfully",
      cake: get_cake(cake)
    }
  end

  def render("create_cake_rating.json", %{cake_rating: cake_rating}) do
    %{
      ok: "Cake avaliation created with successfully",
      cake_rating: get_cake_rating(cake_rating)
    }
  end

  def render("update_cake_category.json", category) do
    %{
      ok: "category updated with successfully",
      category: get_category(category)
    }
  end

  def render("delete_cake_categories.json", %{categories: categories}) do
    %{
      ok: "category deleted with successfully",
      category: get_many_categories(categories)
    }
  end

  def render("show_cake.json", cake) do
    %{
      ok: "Show cake data with successfully",
      cake: get_cake(cake)
    }
  end

  def render("update_cake.json", cake) do
    %{
      ok: "cake updated with successfully",
      cake: get_cake(cake)
    }
  end

  def render("update_cake_photo.json", %{cake_photo: cake_photo}) do
    %{
      ok: "cake photo updated with successfully",
      photo: get_cake_photo(cake_photo)
    }
  end

  def render("delete_cake.json", %{cakes: cakes}) do
    %{
      ok: "cakes deleteds with successfully",
      cakes: get_many_cakes(cakes)
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
           kg: kg,
           cake_category: %CakeCategory{
             name: category_name
           },
           cake_photos: cake_photos,
           cake_ingredients: cake_ingredients,
           cake_ratings: cake_ratings,
           inserted_at: inserted_at
         }
       }) do
    %{
      id: id,
      name: name,
      description: description,
      kg: kg,
      photos: get_cake_photos(cake_photos),
      slug: slug,
      price: price,
      category: category_name,
      ingredients: format_ingredients(cake_ingredients),
      inserted_at: inserted_at,
      ratings: get_cake_ratings(cake_ratings)
    }
  end

  defp get_many_categories(categories) do
    categories
    |> Enum.map(fn category ->
      get_category(%{category: category})
    end)
  end

  defp get_category(%{
         category: %CakeCategory{
           id: id,
           name: name,
           slug: slug,
           inserted_at: inserted_at
         }
       }) do
    %{
      id: id,
      name: name,
      slug: slug,
      inserted_at: inserted_at
    }
  end

  defp get_cake_photos(photos) do
    photos
    |> Enum.map(fn %CakePhoto{} = cake_photo ->
      cake_photo |> get_cake_photo()
    end)
  end

  defp get_cake_photo(%CakePhoto{id: id, url: url, cake_id: cake_id, inserted_at: inserted_at}) do
    %{id: id, url: url, inserted_at: inserted_at, cake: cake_id}
  end

  defp get_cake_rating(%CakeRating{
         id: id,
         title: title,
         description: description,
         stars: stars,
         inserted_at: inserted_at,
         updated_at: updated_at,
         user: %User{} = user,
         cake: %Cake{} = cake
       }) do
    %{
      id: id,
      title: title,
      cake: %{
        id: cake.id,
        name: cake.name
      },
      description: description,
      stars: stars,
      user: get_user(user),
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  defp get_cake_rating(%CakeRating{
         id: id,
         title: title,
         description: description,
         stars: stars,
         inserted_at: inserted_at,
         updated_at: updated_at,
         user: %User{} = user,
         cake: %Cake{cake_category: %CakeCategory{}} = cake
       }) do
    %{
      id: id,
      title: title,
      description: description,
      stars: stars,
      user: get_user(user),
      cake: %{
        id: cake.id,
        name: cake.name,
        category: cake.cake_category.name
      },
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end

  defp get_cake_ratings(cake_ratings) do
    cake_ratings
    |> Enum.map(fn %CakeRating{} = cake_rating ->
      cake_rating |> get_cake_rating()
    end)
  end

  defp get_user(%User{
         id: id,
         name: name,
         surname: surname,
         user_avatar: %UserAvatar{
           id: avatar_id,
           url: url
         },
         inserted_at: inserted_at
       }) do
    %{
      id: id,
      name: name,
      surname: surname,
      avatar: %{
        id: avatar_id,
        url: url
      },
      inserted_at: inserted_at
    }
  end

  defp format_ingredients(ingredients) do
    ingredients
    |> Enum.map(fn %CakeIngredient{id: id, name: name, cake_id: cake_id, inserted_at: inserted_at} ->
      %{id: id, name: name, inserted_at: inserted_at, cake: cake_id}
    end)
  end
end
