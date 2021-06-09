defmodule SaborBrasileiro.Repo.Migrations.CreateCake do
  use Ecto.Migration

  def change do
    create table :cakes do
      add :name, :string
      add :slug, :string
      add :price, :string
      add :description, :string
      add :stars, :integer
      add :is_best, :boolean
      timestamps()
    end

    create unique_index(:cakes, [:name])
    create unique_index(:cakes, [:slug])
  end
end
