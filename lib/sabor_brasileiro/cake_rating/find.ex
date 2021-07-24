defmodule SaborBrasileiro.CakeRatings.Find do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, CakeRatings.Queries}

  def call(query) do
    Multi.new()
    |> Multi.run(:get_ratings, fn repo, _ ->
      get_ratings(repo, query)
    end)
    |> Queries.preload_data(:get_ratings)
    |> run_transaction
  end

  defp get_ratings(repo, query) do
    Queries.get_with(query)
    |> repo.all()
    |> handle_ratings
  end

  defp handle_ratings([]), do: {:error, "Cake Ratings not found"}
  defp handle_ratings(cake_ratings), do: {:ok, cake_ratings}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_rating_data: cake_ratings}} -> {:ok, cake_ratings}
    end
  end
end
