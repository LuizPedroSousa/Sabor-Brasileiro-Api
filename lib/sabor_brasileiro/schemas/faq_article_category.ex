defmodule SaborBrasileiro.FAQArticleCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{FAQArticle}
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name]
  schema "faq_articles_categories" do
    field :name, :string
    has_many :faq_article, FAQArticle
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:name])
  end
end
