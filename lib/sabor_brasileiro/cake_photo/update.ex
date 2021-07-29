defmodule SaborBrasileiro.CakePhotos.Update do
  alias Ecto.{Multi}

  alias SaborBrasileiro.{
    CakePhoto,
    Repo,
    CakePhotos.Queries
  }

  def call(id, params) do
    Multi.new()
    |> Multi.run(:get_cake_photo, fn repo, _ ->
      get_cake_photo(repo, id)
      |> handle_cake_photo()
    end)
    |> Multi.update(:update_cake_photo, fn %{get_cake_photo: cake} ->
      cake |> cake_photo_changeset(params)
    end)
    |> Queries.preload_data(:update_cake_photo)
    |> run_transaction
  end

  defp get_cake_photo(repo, id) do
    Queries.get_with(%{"id" => id})
    |> repo.one()
  end

  defp cake_photo_changeset(cake, params) do
    CakePhoto.changeset_update(cake, params)
  end

  defp handle_cake_photo(cake) do
    case cake do
      nil -> {:error, "Cake Photo not found"}
      %CakePhoto{} = cake_photo -> {:ok, cake_photo}
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_photo_data: cake_photo}} -> {:ok, cake_photo}
    end
  end
end
