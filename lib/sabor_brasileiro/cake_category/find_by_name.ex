defmodule SaborBrasileiro.CakeCategory.FindByName do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{CakeCategory, Repo}

  def call(params) do
    Multi.new()
    |> Multi.run(:find_category, fn repo, _ ->
      find_category(repo, params)
    end)
    |> run_transaction
  end

  defp find_category(repo, name) do
    CakeCategory
    |> repo.get_by(%{name: name})
    |> case do
      nil -> {:error, "Category not exists"}
      %CakeCategory{} = category -> {:ok, category}
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{find_category: category}} -> {:ok, category}
    end
  end
end
