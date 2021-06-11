defmodule SaborBrasileiro.Users.Preload do
  alias Ecto.{Multi}

  def call(multi, key) do
    multi
    |> Multi.run(:preload_data, fn repo, map ->
      preload_data(repo, map[key])
    end)
  end

  defp preload_data(repo, user), do: {:ok, repo.preload(user, [:user_avatar, :user_role])}
end
