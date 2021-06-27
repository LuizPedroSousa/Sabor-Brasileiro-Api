defmodule SaborBrasileiro.FAQArticleCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.{Changeset}
  alias SaborBrasileiro.{FAQArticle}
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name]
  schema "faq_articles_categories" do
    field :name, :string
    field :slug, :string
    has_many :faq_article, FAQArticle
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:name])
    |> unique_constraint([:slug])
    |> put_slug
  end

  defp put_slug(%Changeset{valid?: true, changes: %{name: name}} = changeset) do
    changeset |> change(%{slug: Slugify.slugify(name)})
  end

  defp put_slug(changeset), do: changeset
end
