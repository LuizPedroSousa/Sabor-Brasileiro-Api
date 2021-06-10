defmodule SaborBrasileiro.CakeCategories.Delete do
  alias SaborBrasileiro.{Repo}
  import SaborBrasileiro.CakeCategories.Queries, only: [get_category_by_id: 1]

  def call(id) do
    case get_category_by_id(id) do
      {:ok, category} -> Repo.delete(category)
      {:error, reason} -> {:error, reason}
    end
  end
end
