defmodule SaborBrasileiro.BestConfectioner.Preload do
  alias Ecto.{Multi}

  def call(multi, key) do
    multi
    |> Multi.run(:preload_best_confectioner_data, fn repo, map ->
      preload_best_confectioner(repo, map[key])
    end)
  end

  defp preload_best_confectioner(repo, best_confectioner),
    do: {:ok, repo.preload(best_confectioner, user: :user_avatar)}
end
