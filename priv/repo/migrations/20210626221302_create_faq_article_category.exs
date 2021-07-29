defmodule SaborBrasileiro.Repo.Migrations.CreateFaqArticleCategory do
  use Ecto.Migration

  def change do
    create table :faq_articles_categories do
      add :name, :string
      add :slug, :string
      timestamps()
    end

    create unique_index(:faq_articles_categories, [:name])
  end
end
