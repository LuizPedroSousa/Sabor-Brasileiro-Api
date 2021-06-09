defmodule SaborBrasileiro.Cake do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias SaborBrasileiro.{CakePhoto, CakeCategory}
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name, :slug, :stars, :description, :price]
  schema "cakes" do
    field :name, :string
    field :description, :string
    field :slug, :string
    field :price, :string
    field :stars, :integer, default: 0
    has_many :cake_photos, CakePhoto
    has_one :cake_category, CakeCategory
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> unique_constraint([:name])
    |> unique_constraint([:slug])
    |> validate_required(@required_params)
    |> validate_number(:stars, greater_than_or_equal_to: 0, less_than_or_equal_to: 5)
  end

end
