defmodule SaborBrasileiro.TemporaryUserPin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias SaborBrasileiro.{User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:pin, :user_id]
  schema "temporary_user_pin" do
    field :pin, :string
    field :expires_in, :integer
    belongs_to :user, User
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_length(:pin, min: 6)
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
