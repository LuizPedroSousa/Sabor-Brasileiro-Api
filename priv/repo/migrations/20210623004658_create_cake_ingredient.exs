defmodule SaborBrasileiro.Repo.Migrations.CreateCakeIngredient do
  use Ecto.Migration

  def change do
    create table :cake_ingredients do
      add :name, :string
      add :cake_id, references(:cakes, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end
  end
end
