defmodule SaborBrasileiro.Repo.Migrations.CreateUserAvatar do
  use Ecto.Migration

  def change do
    create table :users_avatar do
      add :url, :string
      add :user_id, references(:users, type: :binary_id)
      timestamps()
    end
  end
end
