defmodule SaborBrasileiro.Cakes.Find do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, Cakes.Queries}

  def call(query_params) do
    Multi.new()
    |> Multi.run(:get_cakes, fn repo, _ ->
      Queries.get_with(query_params)
      |> repo.all()
      |> case do
        [] -> {:error, "Cake not found"}
        cakes -> {:ok, cakes}
      end
    end)
    |> Queries.preload_data(:get_cakes)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cakes}} -> {:ok, cakes}
    end
  end
end
