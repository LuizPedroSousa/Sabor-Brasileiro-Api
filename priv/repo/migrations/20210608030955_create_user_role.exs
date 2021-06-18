defmodule SaborBrasileiro.Repo.Migrations.CreateUserRole do
  use Ecto.Migration

  def change do
    create table :users_roles do
      add :isUser, :boolean
      add :isConfectioner, :boolean
      add :isAdmin, :boolean
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end
  end
end
