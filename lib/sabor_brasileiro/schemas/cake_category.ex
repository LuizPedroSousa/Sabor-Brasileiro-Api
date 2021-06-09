defmodule SaborBrasileiro.CakeCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{Cake}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:name, :cake_id]

  schema "cake_category" do
    field :name, :string
    belongs_to :cake, Cake
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:name])
  end
end
