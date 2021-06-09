defmodule SaborBrasileiro.Repo.Migrations.AlterCake do
  use Ecto.Migration

  def change do
    alter table :cakes do
      add :category_id, references(:cake_category, type: :binary_id)
    end
  end
end
