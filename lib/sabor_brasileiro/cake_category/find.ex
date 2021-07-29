defmodule SaborBrasileiro.CakeCategories.Find do
  alias SaborBrasileiro.{CakeCategories.Queries, Repo}
  alias Ecto.Multi

  def call(query) do
    Multi.new()
    |> Multi.run(:get_categories, fn repo, _ ->
      get_categories(repo, query)
    end)
    |> Queries.preload_data(:get_categories)
    |> run_transaction
  end

  defp get_categories(repo, query) do
    Queries.get_with(query)
    |> repo.all()
    |> handle_categories
  end

  defp handle_categories(categories), do: {:ok, categories}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_category_data: categories}} -> {:ok, categories}
    end
  end
end
