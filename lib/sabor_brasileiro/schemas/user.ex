defmodule SaborBrasileiro.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias SaborBrasileiro.{UserAvatar, RefreshToken, CakeRating}

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name, :nickname, :surname, :email, :password]

  schema "users" do
    field :name, :string
    field :nickname, :string
    field :surname, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :isUser, :boolean, null: false, default: true
    field :isConfectioner, :boolean, null: false, default: false
    field :isAdmin, :boolean, null: false, default: false
    field :isBestConfectioner, :boolean, null: false, default: false
    has_one :user_avatar, UserAvatar
    has_one :refresh_token, RefreshToken
    has_one :cake_rating, CakeRating
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:nickname, min: 4)
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash
  end

  def changeset_update(struct, params) do
    IO.inspect({struct, params})

    struct
    |> cast(params, [
      :name,
      :surname,
      :isBestConfectioner,
      :isConfectioner,
      :email,
      :nickname,
      :password_hash
    ])
    |> validate_required([:name, :surname, :email, :nickname, :password_hash])
    |> validate_length(:nickname, min: 4)
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
  end

  def changeset_auth(params) do
    required_params_auth = [:nickname, :password]

    %__MODULE__{}
    |> cast(params, required_params_auth)
    |> validate_required(required_params_auth)
    |> validate_length(:password, min: 6)
    |> validate_length(:nickname, min: 4)
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset |> change(Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
