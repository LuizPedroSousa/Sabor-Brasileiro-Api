defmodule SaborBrasileiro.CakeCategories.Find do
  import SaborBrasileiro.CakeCategories.Queries,
    only: [get_all_categories: 0, get_categories_by_name: 1]

  def call(query) do
    case query do
      %{"name" => name} -> get_categories_by_name(name)
      %{} -> get_all_categories()
    end
  end
end
