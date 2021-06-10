defmodule SaborBrasileiro.CakeCategories.Update do
  alias SaborBrasileiro.{CakeCategory, Repo}
  import SaborBrasileiro.CakeCategories.Queries, only: [get_category_by_id: 1]

  def call(%{"id" => id}, params) do
    case get_category_by_id(id) do
      {:error, reason} -> {:error, reason}
      {:ok, category} -> CakeCategory.update_changeset(category, params) |> Repo.update()
    end
  end
end
