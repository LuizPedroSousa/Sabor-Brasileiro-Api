defmodule SaborBrasileiro.Cakes.Show do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, Cake, Cakes.Queries}

  def call(slug) do
    Multi.new()
    |> Multi.run(:get_cake, fn repo, _ ->
      get_cake(repo, slug)
    end)
    |> Queries.preload_data(:get_cake)
    |> run_transaction
  end

  defp get_cake(repo, slug) do
    Queries.get_with(%{"slug" => slug})
    |> repo.one()
    |> handle_cake
  end

  defp handle_cake(%Cake{} = cake), do: {:ok, cake}
  defp handle_cake(_), do: {:error, "Cake not found"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cake}} -> {:ok, cake}
    end
  end
end
