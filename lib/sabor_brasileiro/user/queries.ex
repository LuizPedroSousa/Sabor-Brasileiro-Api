defmodule SaborBrasileiro.Users.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{User, UserRole, Repo}
  import SaborBrasileiro, only: [preload_user_data: 2]

  # One
  def get_user_by_id(id) do
    from(u in User,
      where: u.id == ^id
    )
    |> Repo.one()
    |> case do
      nil -> {:error, "User not exists"}
      %User{} = user -> {:ok, user}
    end
  end

  def get_user_by_id(repo, id) do
    from(u in User,
      where: u.id == ^id
    )
    |> repo.one()
    |> case do
      nil -> {:error, "User not exists"}
      %User{} = user -> {:ok, user}
    end
  end

  def get_users_by_name(repo, name) do
    like_name = "%#{name}%"

    from(u in User,
      where: ilike(u.name, ^like_name)
    )
    |> repo.all()
    |> case do
      nil -> {:error, "User not exists"}
      %User{} = user -> {:ok, user}
    end
  end

  def get_confectioner_by_id(multi, id) do
    multi
    |> Multi.run(:get_user, fn repo, _ ->
      case repo.get_by(User, %{id: id}) do
        nil -> {:error, "User not exists"}
        %User{} = user -> {:ok, user}
      end
    end)
    |> preload_user_data(:get_user)
    |> Multi.run(:verify_confectioner, fn _, %{preload_data: %User{} = user} ->
      %{user_role: %UserRole{isConfectioner: is_confectioner}} = user

      case is_confectioner do
        false -> {:error, "User is not a confectioner"}
        true -> {:ok, user}
      end
    end)
  end

  def get_confectioners_by_name(multi, name) do
    multi
    |> Multi.run(:get_user, fn repo, _ ->
      like_name = "%#{name}%"

      from(u in User,
        where: ilike(u.name, ^like_name),
        order_by: [desc: u.inserted_at]
      )
      |> repo.all()
      |> case do
        nil -> {:error, "User not exists"}
        users -> {:ok, users}
      end
    end)
    |> preload_user_data(:get_user)
    |> Multi.run(:verify_confectioner, fn _, %{preload_data: preload_users} ->
      users = Enum.find(preload_users, %User{user_role: %UserRole{isConfectioner: true}})
      {:ok, users}
    end)
  end
end
