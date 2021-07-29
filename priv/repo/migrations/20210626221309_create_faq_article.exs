defmodule SaborBrasileiro.Repo.Migrations.CreateFaqArticle do
  use Ecto.Migration

  def change do
    create table :faq_articles do
      add :title, :string
      add :slug, :string
      add :description, :text
      add :faq_article_category_id, references(:faq_articles_categories, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end

    create unique_index(:faq_articles, [:title])
    create unique_index(:faq_articles, [:slug])
  end
end
