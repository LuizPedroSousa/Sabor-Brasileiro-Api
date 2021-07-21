defmodule SaborBrasileiro.Repo.Migrations.CreateTemporaryUserPin do
  use Ecto.Migration

  def change do
    create table :temporary_user_pin do
      add :pin, :string
      add :expires_in, :naive_datetime
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end
  end
end
