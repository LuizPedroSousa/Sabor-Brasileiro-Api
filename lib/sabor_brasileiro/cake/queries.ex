defmodule SaborBrasileiro.Cakes.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake, CakePhoto}
  import SaborBrasileiro.Utils.Id, only: [validate_ids: 1]
  import SaborBrasileiro, only: [preload_cake_data: 2]

  def get_all_cakes(multi) do
    multi
    |> Multi.run(:get_all_cakes, fn repo, _ ->
      cakes =
        from(c in Cake,
          order_by: [desc: c.inserted_at]
        )
        |> repo.all()

      {:ok, cakes}
    end)
    |> preload_cake_data(:get_all_cakes)
  end

  def get_cakes_with(multi, query) do
    multi
    |> Multi.run(:get_cakes, fn repo, _ ->
      like_category = "%#{query["category"]}%"
      like_name = "%#{query["name"]}%"

      query =
        case is_nil(query["stars"]) do
          true ->
            from(c in Cake,
              join: cc in "cake_category",
              on: c.cake_category_id == cc.id and ilike(cc.name, ^like_category),
              where: ilike(c.name, ^like_name),
              limit: ^query["_limit"],
              order_by: [desc: c.inserted_at]
            )

          false ->
            from(c in Cake,
              join: cc in "cake_category",
              on: c.cake_category_id == cc.id and ilike(cc.name, ^like_category),
              where: ilike(c.name, ^like_name) and c.stars >= ^query["stars"],
              order_by: [desc: c.inserted_at]
            )
        end

      {:ok, repo.all(query)}
    end)
    |> preload_cake_data(:get_cakes)
  end

  def get_cake_by_id(multi, id) do
    multi
    |> Multi.run(:get_cake, fn repo, _ ->
      from(c in Cake,
        where: c.id == ^id
      )
      |> repo.one
      |> case do
        nil -> {:error, "Cake not found"}
        %Cake{} = cake -> {:ok, cake}
      end
    end)
    |> preload_cake_data(:get_cake)
  end

  def get_cake_by_slug(multi, slug) do
    multi
    |> Multi.run(:get_cake, fn repo, _ ->
      from(c in Cake,
        where: ilike(c.slug, ^slug),
        order_by: [desc: c.inserted_at]
      )
      |> repo.one()
      |> case do
        nil -> {:error, "Cake not found"}
        %Cake{} = cake -> {:ok, cake}
      end
    end)
    |> preload_cake_data(:get_cake)
  end

  def delete_with_ids(multi, ids) do
    multi
    |> Multi.run(:get_cakes, fn repo, _ ->
      case validate_ids(ids) do
        :ok ->
          from(c in Cake,
            where: c.id in ^ids
          )
          |> repo.all()
          |> case do
            [] -> {:error, "Cakes not found"}
            cakes -> {:ok, cakes}
          end

        error ->
          error
      end
    end)
    |> preload_cake_data(:get_cakes)
    |> Multi.delete_all(:delete_photos, fn _ ->
      from(p in CakePhoto,
        where: p.cake_id in ^ids
      )
    end)
    |> Multi.delete_all(:delete_cake, fn _ ->
      from(c in Cake,
        where: c.id in ^ids
      )
    end)
  end
end
