defmodule SaborBrasileiro.Users.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{User, UserRole, Repo}
  import SaborBrasileiro, only: [preload_user_data: 2]

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
end
