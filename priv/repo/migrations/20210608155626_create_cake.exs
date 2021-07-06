defmodule SaborBrasileiro.Repo.Migrations.CreateCake do
  use Ecto.Migration

  def change do
    create table :cakes do
      add :name, :string
      add :slug, :string
      add :price, :string
      add :description, :text
      add :stars, :integer
      add :kg, :string
      timestamps()
    end

    create unique_index(:cakes, [:name])
    create unique_index(:cakes, [:slug])
  end
end
