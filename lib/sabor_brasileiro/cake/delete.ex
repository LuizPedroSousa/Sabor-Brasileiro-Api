defmodule SaborBrasileiro.Cakes.Delete do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo}
  alias SaborBrasileiro.Cakes.Queries

  def call(id) do
    id_list = id |> String.split(",")
    Multi.new() |> Queries.delete_with_ids(id_list) |> run_transaction

    # Multi.new() |> find_with_ids(id) |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cakes}} -> {:ok, cakes}
    end
  end
end
