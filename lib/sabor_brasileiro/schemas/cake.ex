defmodule SaborBrasileiro.Cake do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias SaborBrasileiro.{CakePhoto, CakeCategory, CakeIngredient, CakeRating}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:name, :kg, :cake_category_id, :stars, :description, :price]

  schema "cakes" do
    field :name, :string
    field :description, :string
    field :slug, :string
    field :price, :string
    field :stars, :integer, default: 0
    field :kg, :string
    has_many :cake_photos, CakePhoto
    has_many :cake_ingredients, CakeIngredient
    has_many :cake_rating, CakeRating
    belongs_to :cake_category, CakeCategory
    timestamps()
  end

  def changeset(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> unique_constraint([:name])
    |> unique_constraint([:slug])
    |> validate_required(@required_params)
    |> validate_number(:stars, greater_than_or_equal_to: 0, less_than_or_equal_to: 5)
    |> put_slug
  end

  def changeset_update(cake, params) do
    cake
    |> cast(format_params(params), @required_params)
    |> unique_constraint([:name])
    |> unique_constraint([:slug])
    |> validate_required(@required_params)
    |> validate_number(:stars, greater_than_or_equal_to: 0, less_than_or_equal_to: 5)
    |> put_slug
    |> change
  end

  defp format_params(params) do
    for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}
  end

  defp put_slug(%Changeset{valid?: true, changes: %{name: name}} = changeset) do
    changeset |> change(%{slug: Slugify.slugify(name)})
  end

  defp put_slug(changeset), do: changeset
end
