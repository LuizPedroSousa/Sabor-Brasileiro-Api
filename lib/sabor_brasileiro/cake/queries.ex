defmodule SaborBrasileiro.Cakes.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake}
  import SaborBrasileiro, only: [preload_cake_data: 2]

  def get_all_cakes(multi) do
    multi
    |> Multi.run(:get_all_cakes, fn repo, _ ->
      cakes = from(c in Cake,
        order_by: [desc: c.inserted_at]
      )
      |> repo.all()
      {:ok, cakes}
    end)
    |> preload_cake_data(:get_all_cakes)
  end

  def get_cakes_by_category(multi, category) do
    multi
    |> Multi.run(:get_cakes, fn repo, _ ->
      like_category = "%#{category}%"
      cakes =
        from(c in Cake,
          join: cc in "cake_category",
          on: c.cake_category_id == cc.id and ilike(cc.name, ^like_category),
          order_by: [desc: c.inserted_at]
        )
        |> repo.all()
      {:ok, cakes}
    end)
    |> preload_cake_data(:get_cakes)
  end
end
