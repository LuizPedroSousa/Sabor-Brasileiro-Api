defmodule SaborBrasileiro.UserRole do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:isUser, :isConfectioner, :isAdmin, :user_id]

  schema "users_roles" do
    field :isUser, :boolean, null: false, default: true
    field :isConfectioner, :boolean, null: false, default: false
    field :isAdmin, :boolean, null: false, default: false
    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
