defmodule SaborBrasileiro.BestConfectioner do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:user_id]

  schema "best_confectioners" do
    belongs_to :user, User
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> unique_constraint([:user_id])
    |> validate_required(@required_params)
  end
end
