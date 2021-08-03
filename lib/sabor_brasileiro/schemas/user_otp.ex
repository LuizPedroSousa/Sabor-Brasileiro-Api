defmodule SaborBrasileiro.UserOTP do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{User}
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:otp_secret, :otp_code, :user_id]
  schema "user_otp" do
    field :otp_code, :string
    field :otp_secret, :string
    field :expires_in, :integer
    belongs_to :user, User
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_expiration
  end

  defp put_expiration(%Changeset{valid?: true} = changeset) do
    expires_in =
      Timex.now()
      |> Timex.shift(minutes: 10)
      |> Timex.to_unix()

    changeset
    |> change(%{
      expires_in: expires_in
    })
  end

  defp put_expiration(changeset), do: changeset
end
