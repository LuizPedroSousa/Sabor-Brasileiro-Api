defmodule SaborBrasileiro.Repo.Migrations.CreateRefreshToken do
  use Ecto.Migration

  def change do
    create table :refresh_token do
      add :expires_in, :integer
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end
  end
end
