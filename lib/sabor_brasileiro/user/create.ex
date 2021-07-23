defmodule SaborBrasileiro.Users.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{User, UserAvatar, Repo, Users.Queries}

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_avatar, fn repo, %{create_user: %User{id: user_id}} ->
      create_avatar(repo, params, user_id)
    end)
    |> Queries.preload_data(:create_user)
    |> run_transaction
  end

  defp create_avatar(repo, params, user_id) do
    avatar_changeset(params, user_id)
    |> repo.insert()
  end

  defp avatar_changeset(params, user_id) do
    params
    |> Map.merge(%{"user_id" => user_id})
    |> UserAvatar.changeset()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_user_data: user}} -> {:ok, user}
    end
  end
end
