defmodule SaborBrasileiro.Repo.Migrations.CreateCakeCategory do
  use Ecto.Migration

  def change do
    create table :cake_category do
      add :name, :string
      timestamps()
    end

    create unique_index(:cake_category, [:name])
  end
end
