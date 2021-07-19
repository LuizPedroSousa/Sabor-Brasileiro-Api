defmodule SaborBrasileiro.Cakes.Create do
  alias Ecto.{Multi}

  alias SaborBrasileiro.{
    Cake,
    CakePhoto,
    CakeCategory,
    CakeIngredient,
    Repo,
    Cakes.Queries,
    CakeCategories
  }

  def call(params) do
    Multi.new()
    |> Multi.run(:get_category, fn repo, _ ->
      get_category(repo, params)
    end)
    |> Multi.insert(
      :create_cake,
      fn %{get_category: %CakeCategory{id: category_id}} ->
        cake_changeset(params, category_id)
      end
    )
    |> Multi.run(:create_photos, fn repo, %{create_cake: %Cake{id: id}} ->
      insert_photos(repo, id, params)
    end)
    |> Multi.run(:create_ingredients, fn repo, %{create_cake: %Cake{id: id}} ->
      insert_ingredients(repo, id, params)
    end)
    |> Queries.preload_data(:create_cake)
    |> run_transaction
  end

  defp get_category(repo, %{"category" => category}) do
    CakeCategories.Queries.get_with(%{"_name" => category})
    |> repo.one()
    |> handle_category
  end

  defp get_category(_repo, _), do: {:error, %{category: ["can't be blank"]}}

  defp handle_category(%CakeCategory{} = category), do: {:ok, category}
  defp handle_category(_), do: {:error, "Cake category not found"}

  defp cake_changeset(params, category_id) do
    Map.merge(params, %{"cake_category_id" => category_id})
    |> Cake.changeset()
  end

  defp insert_photos(repo, cake_id, %{"photos" => photos}) do
    inserted_photos =
      photos
      |> photos_changesets(cake_id)
      |> Enum.map(fn photo -> repo.insert(photo) end)

    {:ok, inserted_photos}
  end

  defp insert_photos(_repo, _cake_id, _any_value),
    do: {:error, %{photos: ["can't be blank"]}}

  defp insert_ingredients(repo, cake_id, %{"ingredients" => ingredients}) do
    inserted_ingredients =
      ingredients
      |> ingredients_changesets(cake_id)
      |> Enum.map(fn ingredient -> repo.insert(ingredient) end)

    {:ok, inserted_ingredients}
  end

  defp insert_ingredients(_repo, _cake_id, _any),
    do: {:error, %{ingredients: ["can't be blank"]}}

  defp ingredients_changesets(ingredients, cake_id) do
    ingredients
    |> Enum.map(fn ingredient ->
      CakeIngredient.changeset(%{name: ingredient["name"], cake_id: cake_id})
    end)
  end

  defp photos_changesets(photos, cake_id) do
    photos
    |> Enum.map(fn photo ->
      CakePhoto.changeset(%{url: photo["url"], cake_id: cake_id})
    end)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cake}} -> {:ok, cake}
    end
  end
end
