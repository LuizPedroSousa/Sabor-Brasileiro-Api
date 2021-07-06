defmodule SaborBrasileiro.Cakes.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake, CakePhoto, CakeCategory, CakeIngredient, Repo, Cakes.Queries}
  import SaborBrasileiro.CakeCategories.Queries, only: [get_category_by_name: 1]

  def call(params) do
    case get_category_by_name(params["category"]) do
      {:ok, %CakeCategory{id: category_id}} ->
        Multi.new()
        |> Multi.insert(
          :create_cake,
          cake_changeset(params, category_id)
        )
        |> Multi.run(:create_photos, fn repo, %{create_cake: %Cake{id: id}} ->
          insert_photos(repo, id, params)
        end)
        |> Multi.run(:create_ingredients, fn repo, %{create_cake: %Cake{id: id}} ->
          insert_ingredients(repo, id, params)
        end)
        |> Queries.preload_data(:create_cake)
        |> run_transaction

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp cake_changeset(params, category_id) do
    Map.merge(params, %{"cake_category_id" => category_id})
    |> Cake.changeset()
  end

  defp insert_photos(repo, cake_id, params) do
    case params["photos"] do
      nil ->
        {:error, %{photos: "photos: can't be blank"}}

      _any_value ->
        photos =
          params["photos"]
          |> photos_changesets(cake_id)
          |> Enum.map(fn photo -> repo.insert(photo) end)

        {:ok, photos}
    end
  end

  defp photos_changesets(photos, cake_id) do
    photos
    |> Enum.map(fn photo ->
      CakePhoto.changeset(%{url: photo["url"], cake_id: cake_id})
    end)
  end

  defp insert_ingredients(repo, cake_id, params) do
    case params["ingredients"] do
      nil ->
        {:error, %{ingredients: "ingredients: can't be blank"}}

      _any_value ->
        ingredients =
          params["ingredients"]
          |> ingredients_changesets(cake_id)
          |> Enum.map(fn ingredient -> repo.insert(ingredient) end)

        {:ok, ingredients}
    end
  end

  defp ingredients_changesets(ingredients, cake_id) do
    ingredients
    |> Enum.map(fn ingredient ->
      CakeIngredient.changeset(%{name: ingredient["name"], cake_id: cake_id})
    end)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cake}} -> {:ok, cake}
    end
  end
end
