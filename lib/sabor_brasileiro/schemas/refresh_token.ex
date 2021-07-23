defmodule SaborBrasileiro.RefreshToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias SaborBrasileiro.{User}
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:user_id]
  schema "refresh_token" do
    field :expires_in, :integer
    belongs_to :user, User
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_expiration
  end

  defp put_expiration(%Changeset{valid?: true} = changeset) do
    IO.inspect(Timex.now() |> Timex.to_unix())

    expires_in =
      Timex.now()
      |> Timex.shift(days: 14)
      |> Timex.to_unix()

    changeset
    |> change(%{
      expires_in: expires_in
    })
  end

  defp put_expiration(changeset), do: changeset
end
