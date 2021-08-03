defmodule SaborBrasileiro.Repo.Migrations.CreateUserOTP do
  use Ecto.Migration

  def change do
    create table :user_otp do
      add :otp_secret, :string
      add :otp_code, :string
      add :expires_in, :integer
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)
      timestamps()
    end
  end
end
