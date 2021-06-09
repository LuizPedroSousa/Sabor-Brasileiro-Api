defmodule SaborBrasileiro.Cakes.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake, CakePhoto, CakeCategory, Repo}
  import SaborBrasileiro, only: [preload_cake_data: 2, find_category_name: 1]

  def call(params) do
    case find_category_name(params["category"]) do
      {:ok, %CakeCategory{id: category_id}} ->
        Multi.new()
        |> Multi.insert(
          :create_cake,
          cake_changeset(params, category_id)
        )
        |> Multi.run(:create_photos, fn repo, %{create_cake: %{id: id}} ->
          insert_photos(repo, id, params)
        end)
        |> preload_cake_data(:create_cake)
        |> run_transaction

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp cake_changeset(params, category_id) do
    Map.merge(params, %{"category_id" => category_id})
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

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: cake}} -> {:ok, cake}
    end
  end
end
