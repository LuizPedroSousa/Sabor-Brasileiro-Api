defmodule SaborBrasileiro.Cakes.Preload do
  alias Ecto.{Multi}

  def call(multi, key) do
    multi
    |> Multi.run(:preload_cake_data, fn repo, map ->
      preload_data(repo, map[key])
    end)
  end

  defp preload_data(repo, cake), do: {:ok, repo.preload(cake, [:cake_photos, :cake_category])}
end
