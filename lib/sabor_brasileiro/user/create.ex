defmodule SaborBrasileiro.Users.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{User, UserAvatar, UserRole, Repo}
  import SaborBrasileiro, only: [preload_user_data: 2]

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_avatar, fn repo, %{create_user: %{id: id}} ->
      insert_avatar(repo, id, params)
    end)
    |> Multi.run(:create_role, fn repo, %{create_user: %{id: id}} ->
      insert_role(repo, id)
    end)
    |> preload_user_data(:create_user)
    |> run_transaction
  end

  defp insert_avatar(repo, user_id, params) do
    case params["avatar"] do
      nil ->
        {:error, %{avatar: "avatar can't be blank"}}

      _any_result ->
        params["avatar"]["url"] |> avatar_changeset(user_id) |> repo.insert
    end
  end

  defp insert_role(repo, user_id) do
    %{
      user_id: user_id
    }
    |> UserRole.changeset()
    |> repo.insert()
  end

  defp avatar_changeset(url, user_id) do
    %{url: url, user_id: user_id}
    |> UserAvatar.changeset()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
