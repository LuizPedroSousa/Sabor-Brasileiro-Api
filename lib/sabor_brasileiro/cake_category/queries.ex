defmodule SaborBrasileiro.CakeCategories.Queries do
  import Ecto.Query
  alias SaborBrasileiro.{CakeCategory, Repo}

  def get_category_by_name(name) do
    like_name = "%#{name}%"

    from(c in CakeCategory,
      where: ilike(c.name, ^like_name),
      order_by: c.inserted_at
    )
    |> Repo.one()
    |> case do
      nil -> {:error, "Category not exists"}
      %CakeCategory{} = category -> {:ok, category}
    end
  end

  def get_category_by_id(id) do
    from(c in CakeCategory,
      where: c.id == ^id,
      order_by: c.inserted_at
    )
    |> Repo.one()
    |> case do
      nil -> {:error, "Category not exists"}
      %CakeCategory{} = category -> {:ok, category}
    end
  end
end
