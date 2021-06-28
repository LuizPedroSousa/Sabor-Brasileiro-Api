defmodule SaborBrasileiro.Cakes.Show do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo}
  import SaborBrasileiro.Cakes.Queries, only: [get_cake_by_slug: 2]

  def call(slug) do
    Multi.new()
    |> get_cake_by_slug(slug)
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cake}} -> {:ok, cake}
    end
  end
end
