defmodule SaborBrasileiro.Cakes.Create do
  alias Ecto.{Multi, Changeset}
  alias SaborBrasileiro.{Cake, CakePhoto, CakeCategory, Repo}
  import SaborBrasileiro, only: [preload_cake_data: 2]

  def call(params) do
    Multi.new()
    |> Multi.insert(
      :create_cake,
      Cake.changeset(params)
    )
    |> Multi.run(:create_photos, fn repo, %{create_cake: %{id: id}} ->
      insert_photos(repo, id, params)
    end)
    |> Multi.run(:create_category, fn repo, %{create_cake: %{id: id}} ->
      insert_category(repo, id, params)
    end)
    |> preload_cake_data(:create_cake)
    |> run_transaction
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

  defp insert_category(repo, cake_id, %{"category" => category}) do
    category
    |> category_changeset(cake_id)
    |> repo.insert()
  end

  defp category_changeset(name, cake_id) do
    %{
      name: name,
      cake_id: cake_id
    }
    |> CakeCategory.changeset()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: cake}} -> {:ok, cake}
    end
  end
end
