defmodule SaborBrasileiro.CakeRatings.Queries do
  alias Ecto.Multi

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_cake_rating_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :cake,
         :user
       ])}
    end)
  end
end
