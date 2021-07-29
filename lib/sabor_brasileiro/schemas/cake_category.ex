defmodule SaborBrasileiro.CakeCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias SaborBrasileiro.{Cake}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:name]

  schema "cake_category" do
    field :name, :string
    field :slug, :string
    has_many :cake, Cake
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:name])
    |> put_slug
  end

  def update_changeset(category, params) do
    formatted_params = format_params(params)

    category
    |> cast(formatted_params, @required_params)
    |> validate_required(@required_params)
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
