defmodule SaborBrasileiro.CakeRating do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{Cake, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:title, :description, :stars, :cake_id, :user_id]
  schema "cake_ratings" do
    field :title, :string
    field :description, :string
    field :stars, :integer, default: 0
    belongs_to :user, User
    belongs_to :cake, Cake
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:title, greater_than_or_equal_to: 4)
    |> validate_number(:stars, greater_than_or_equal_to: 0, less_than_or_equal_to: 5)
  end
end
