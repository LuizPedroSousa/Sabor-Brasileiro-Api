defmodule SaborBrasileiro.FaqArticleCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{FaqArticle}
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name]
  schema "faq_articles_categories" do
    field :name, :string
    has_many :faq_article, FaqArticle
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:name])
  end
end
