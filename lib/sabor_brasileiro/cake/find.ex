defmodule SaborBrasileiro.Cakes.Find do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake, Repo}

  import SaborBrasileiro.Cakes.Queries,
    only: [get_all_cakes: 1, get_cakes_with: 2]

  def call(query) do
    multi = Multi.new()

    case query do
      _any_value -> multi |> get_cakes_with(query) |> run_transaction
      %{} -> multi |> get_all_cakes |> run_transaction
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cakes}} -> {:ok, cakes}
    end
  end
end
