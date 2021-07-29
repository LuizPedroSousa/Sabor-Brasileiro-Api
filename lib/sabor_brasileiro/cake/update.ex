defmodule SaborBrasileiro.Cakes.Update do
  alias Ecto.{Multi}

  alias SaborBrasileiro.{
    Cake,
    Repo,
    Cakes.Queries,
    CakeCategories,
    CakeCategory
  }

  def call(slug, params) do
    Multi.new()
    |> Multi.run(:get_cake, fn repo, _ ->
      get_cake(repo, slug)
    end)
    |> Multi.run(:get_category, fn repo, _ ->
      get_category(repo, params)
    end)
    |> Multi.update(:update_cake, fn %{get_cake: cake, get_category: category} ->
      cake_changeset(cake, params, category)
    end)
    |> Queries.preload_data(:update_cake)
    |> run_transaction
  end

  defp get_cake(repo, slug) do
    Queries.get_with(%{"slug" => slug})
    |> repo.one()
    |> handle_cake
  end

  defp get_category(repo, %{"category" => category}) do
    CakeCategories.Queries.get_with(%{"_name" => category})
    |> repo.one()
    |> handle_category
  end

  defp get_category(_, _), do: {:ok, nil}

  defp cake_changeset(cake, params, %CakeCategory{id: category_id}) do
    update_params =
      Map.merge(params, %{"category_id" => category_id})
      |> Map.delete("category")

    Cake.changeset_update(cake, update_params)
  end

  defp cake_changeset(cake, params, _) do
    Cake.changeset_update(cake, params)
  end

  defp handle_cake(%Cake{} = cake), do: {:ok, cake}
  defp handle_cake(_), do: {:error, "Cake not found"}
  defp handle_category(%CakeCategory{} = category), do: {:ok, category}
  defp handle_category(_), do: {:error, "Cake category not found"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_cake_data: cake}} -> {:ok, cake}
    end
  end
end
