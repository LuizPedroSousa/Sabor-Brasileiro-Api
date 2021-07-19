defmodule SaborBrasileiro.CakeCategories.Update do
  alias SaborBrasileiro.{CakeCategory, Repo, CakeCategories.Queries}

  alias Ecto.Multi

  def call(%{"id" => id}, params) do
    Multi.new()
    |> Multi.run(:get_category, fn repo, _ ->
      get_category(repo, id)
    end)
    |> Multi.update(:update_category, fn %{get_category: %CakeCategory{} = category} ->
      CakeCategory.update_changeset(category, params)
    end)
    |> Queries.preload_data(:update_category)
    |> run_transaction()
  end

  defp get_category(repo, id) do
    Queries.get_with(%{"id" => id})
    |> repo.one()
    |> handle_category
  end

  defp handle_category(%CakeCategory{} = category), do: {:ok, category}
  defp handle_category(_), do: {:error, "Cake category not found"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_category_data: category}} -> {:ok, category}
    end
  end
end
