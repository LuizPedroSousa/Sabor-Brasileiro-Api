defmodule SaborBrasileiro.Repo.Migrations.CreateFaqSolicitation do
  use Ecto.Migration

  def change do
    create table :faq_solicitations do
      add :name, :string
      add :surname, :string
      add :email, :string
      add :reason, :string, default: "outros"
      add :subject, :string
      add :description, :text
      timestamps()
    end
  end
end
