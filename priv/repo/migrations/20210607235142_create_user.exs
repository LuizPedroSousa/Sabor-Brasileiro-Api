defmodule SaborBrasileiro.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table :users do
      add :name, :string
      add :nickname, :string
      add :surname, :string
      add :email, :string
      add :password_hash, :string
      add :isUser, :boolean
      add :isConfectioner, :boolean
      add :isAdmin, :boolean
      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end
