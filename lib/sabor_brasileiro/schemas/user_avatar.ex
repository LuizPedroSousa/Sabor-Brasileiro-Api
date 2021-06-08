defmodule SaborBrasileiro.UserAvatar do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:url, :user_id]

  schema "users_avatar" do
    field :url, :string
    belongs_to :user, User
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
