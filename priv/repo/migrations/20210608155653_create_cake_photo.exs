defmodule SaborBrasileiro.Repo.Migrations.CreateCakePhoto do
  use Ecto.Migration

  def change do
    create table :cake_photos do
      add :url, :text
      add :cake_id, references(:cakes, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end
  end
end
