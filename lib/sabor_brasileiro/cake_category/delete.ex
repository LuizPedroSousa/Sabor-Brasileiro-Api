defmodule SaborBrasileiro.CakeCategories.Delete do
  alias SaborBrasileiro.{Repo, CakeCategories.Queries}
  alias Ecto.Multi

  def call(ids) do
    id_list =
      ids
      |> String.split(",")

    Multi.new()
    |> Multi.run(:get_categories, fn repo, _ ->
      get_categories(repo, id_list)
    end)
    |> Multi.delete_all(:delete_categories, fn _ ->
      Queries.get_with(%{"ids" => id_list})
    end)
    |> Queries.preload_data(:get_categories)
    |> run_transaction()
  end

  defp get_categories(repo, id_list) do
    Queries.get_with(%{"ids" => id_list})
    |> repo.all()
    |> handle_categories
  end

  defp handle_categories([]), do: {:error, "Cake categories not found"}
  defp handle_categories(categories), do: {:ok, categories}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_category_data: categories}} -> {:ok, categories}
    end
  end
end
