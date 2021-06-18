defmodule SaborBrasileiro.Repo.Migrations.CreateUserAvatar do
  use Ecto.Migration

  def change do
    create table :users_avatar do
      add :url, :text
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end
  end
end
