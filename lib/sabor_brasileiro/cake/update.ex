defmodule SaborBrasileiro.Cakes.Update do
  alias Ecto.{Multi}

  alias SaborBrasileiro.{
    Cake,
    Repo,
    Cakes.Queries
  }

  def call(slug, params) do
    Multi.new()
    |> Multi.run(:get_cake, fn repo, _ ->
      get_cake(repo, slug)
      |> handle_cake
    end)
    |> Multi.update(:update_cake, fn %{get_cake: cake} ->
      cake |> cake_changeset(params)
    end)
    |> Queries.preload_data(:update_cake)
    |> run_transaction
  end

  defp get_cake(repo, slug) do
    Queries.get_by_slug(slug)
    |> repo.one()
  end

  defp cake_changeset(cake, params) do
    Cake.changeset_update(cake, params)
  end

  defp handle_cake(cake) do
    case cake do
      nil -> {:error, "Cake not found"}
      %Cake{} = cake -> {:ok, cake}
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cake}} -> {:ok, cake}
    end
  end
end
