defmodule SaborBrasileiro.BestConfectioners.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{BestConfectioner, Repo}
  import SaborBrasileiro, only: [preload_best_confectioner: 2, preload_user_data: 2]

  # Many
  def get_all_best_confectioners() do
    from(b in BestConfectioner,
      order_by: [desc: b.inserted_at]
    )
    |> Repo.all()
  end

  def get_all_best_confectioners(multi, %{limit: limit} \\ "") do
    multi
    |> Multi.run(:get_all_confectioners, fn repo, _ ->
      confectioners =
        from(b in BestConfectioner,
          order_by: [desc: b.inserted_at],
          join: u in "users",
          on: u.id == b.user_id,
          limit: ^limit
        )
        |> repo.all()

      {:ok, confectioners}
    end)
    |> preload_best_confectioner(:get_all_confectioners)
  end

  def get_best_confectioners_by_name(multi, name) do
    multi
    |> Multi.run(:get_confectioner, fn repo, _ ->
      like_name = "%#{name}%"

      confectioners =
        from(b in BestConfectioner,
          join: u in "users",
          on: u.id == b.user_id and ilike(u.name, ^like_name),
          order_by: [desc: b.inserted_at]
        )
        |> repo.all()

      {:ok, confectioners}
    end)
    |> preload_best_confectioner(:get_confectioner)
  end

  def get_best_confectioner_by_id(multi, id) do
    multi
    |> Multi.run(:get_confectioner, fn repo, _ ->
      BestConfectioner
      |> repo.get_by(%{id: id})
      |> case do
        nil -> {:error, "Best confectioner not exists"}
        %BestConfectioner{} = best_confectioner -> {:ok, best_confectioner}
      end
    end)
  end
end