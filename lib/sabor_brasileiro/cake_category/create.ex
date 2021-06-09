defmodule SaborBrasileiro.CakeCategories.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, CakeCategory}

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_category, CakeCategory.changeset(params))
    |> run_transaction
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{create_category: category}} -> {:ok, category}
    end
  end
end
