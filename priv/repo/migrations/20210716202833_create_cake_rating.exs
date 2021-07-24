defmodule SaborBrasileiro.Repo.Migrations.CreateCakeRating do
  use Ecto.Migration

  def change do
      create table :cake_ratings do
        add :title, :string
        add :description, :text
        add :stars, :integer
        add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
        add :cake_id, references(:cakes, type: :binary_id, on_delete: :delete_all)
        timestamps()
      end
  end
end
