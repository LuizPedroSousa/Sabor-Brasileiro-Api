defmodule SaborBrasileiro.CakeCategories.Queries do
  import Ecto.Query
  alias Ecto.{UUID}
  alias SaborBrasileiro.{CakeCategory, Repo}

  # One
  def get_category_by_name(name) do
    like_name = "%#{name}%"

    from(c in CakeCategory,
      where: ilike(c.name, ^like_name),
      order_by: [desc: c.inserted_at]
    )
    |> Repo.one()
    |> case do
      nil -> {:error, "Category not exists"}
      %CakeCategory{} = category -> {:ok, category}
    end
  end

  def get_category_by_id(id) do
    case UUID.cast(id) do
      :error ->
        {:error, "Invalid uuid"}

      {:ok, _} ->
        from(c in CakeCategory,
          where: c.id == ^id
        )
        |> Repo.one()
        |> case do
          %CakeCategory{} = category -> {:ok, category}
          _ -> {:error, "Category not exists"}
        end
    end
  end

  # Many
  def get_categories_by_name(name) do
    like_name = "%#{name}%"

    from(c in CakeCategory,
      where: ilike(c.name, ^like_name),
      order_by: [desc: c.inserted_at]
    )
    |> Repo.all()
    |> case do
      nil -> {:error, "Category not exists"}
      categories -> {:ok, categories}
    end
  end

  def get_all_categories() do
    categories =
      from(c in CakeCategory,
        order_by: [desc: c.inserted_at]
      )
      |> Repo.all()

    {:ok, categories}
  end
end
