defmodule SaborBrasileiro.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias SaborBrasileiro.{UserAvatar, UserRole, BestConfectioner}

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name, :surname, :email, :password]

  schema "users" do
    field :name, :string
    field :surname, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_one :user_avatar, UserAvatar
    has_one :user_role, UserRole
    has_one :best_confectioner, BestConfectioner
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset |> change(Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
