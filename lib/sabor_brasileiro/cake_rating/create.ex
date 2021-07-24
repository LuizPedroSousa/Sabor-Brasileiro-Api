defmodule SaborBrasileiro.CakeRatings.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{CakeRating, Repo, Cakes, Cake, CakeRatings.Queries}

  def call(params, assigns) do
    Multi.new()
    |> Multi.run(:get_cake, fn repo, _ ->
      get_cake(repo, params)
    end)
    |> Multi.insert(:create_cake_rating, fn _ ->
      cake_rating_changeset(params, assigns)
    end)
    |> Queries.preload_data(:create_cake_rating)
    |> run_transaction
  end

  defp get_cake(repo, %{"cake_id" => cake_id}) do
    Cakes.Queries.get_with(%{"id" => cake_id})
    |> repo.one()
    |> handle_cake
  end

  defp get_cake(_repo, _), do: {:error, %{cake_id: ["can't be blank'"]}}

  defp cake_rating_changeset(params, %{user_id: user_id}) do
    merged_params = Map.merge(params, %{"user_id" => user_id})
    CakeRating.changeset(merged_params)
  end

  defp handle_cake(%Cake{} = cake), do: {:ok, cake}
  defp handle_cake(_), do: {:error, "Cake not found"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_rating_data: cake_rating}} -> {:ok, cake_rating}
    end
  end
end
