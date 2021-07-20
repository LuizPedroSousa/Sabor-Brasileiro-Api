defmodule SaborBrasileiro.Cakes.Find do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, Cakes.Queries}

  def call(query) do
    Multi.new()
    |> Multi.run(:get_cakes, fn repo, _ ->
      get_cakes(repo, query)
    end)
    |> Queries.preload_data(:get_cakes)
    |> run_transaction
  end

  defp get_cakes(repo, query) do
    Queries.get_with(query)
    |> repo.all()
    |> handle_cakes
  end

  defp handle_cakes([]), do: {:error, "Cakes not found"}
  defp handle_cakes(cakes), do: {:ok, cakes}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cakes}} -> {:ok, cakes}
    end
  end
end
