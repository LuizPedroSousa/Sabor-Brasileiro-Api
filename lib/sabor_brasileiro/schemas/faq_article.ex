defmodule SaborBrasileiro.FAQArticle do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.{Changeset}
  alias SaborBrasileiro.{FAQArticleCategory}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:title, :description, :faq_article_category_id]

  schema "faq_articles" do
    field :title, :string
    field :slug, :string
    field :description, :string
    belongs_to :faq_article_category, FAQArticleCategory
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:title])
    |> put_slug()
    |> unique_constraint([:slug])
  end

  defp put_slug(%Changeset{valid?: true, changes: %{title: title}} = changeset) do
    changeset |> change(%{slug: Slugify.slugify(title)})
  end

  defp put_slug(changeset), do: changeset
end
