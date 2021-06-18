defmodule SaborBrasileiro.Repo.Migrations.CreateBestConfectioner do
  use Ecto.Migration

  def change do
    create table :best_confectioners do
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end

    create unique_index(:best_confectioners, [:user_id])
  end
end
