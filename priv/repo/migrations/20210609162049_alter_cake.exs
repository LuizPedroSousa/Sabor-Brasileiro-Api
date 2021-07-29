defmodule SaborBrasileiro.Repo.Migrations.AlterCake do
  use Ecto.Migration

  def change do
    alter table :cakes do
      add :cake_category_id, references(:cake_category, type: :binary_id, on_delete: :delete_all)
    end
  end
end
