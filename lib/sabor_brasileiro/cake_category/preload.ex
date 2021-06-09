defmodule SaborBrasileiro.CakeCategories.Preload do
  alias Ecto.{Multi}

  def call(multi, key) do
    multi
    |> Multi.run(:preload_data, fn repo, map ->
      preload_data(repo, map[key])
    end)
  end

  defp preload_data(repo, category) do
    {:ok, repo.preload(category, :cake)}
  end
end
