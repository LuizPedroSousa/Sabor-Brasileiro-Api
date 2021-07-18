defmodule SaborBrasileiro.UserAvatar do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias SaborBrasileiro.{User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:avatar, :user_id]

  schema "users_avatar" do
    field(:avatar, :map, virtual: true)
    field :url, :string
    belongs_to :user, User
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_avatar_format(params)
    |> validate_required(@required_params)
  end

  defp validate_avatar_format(%Changeset{valid?: true} = changeset, %{"avatar" => avatar}) do
    case avatar["url"] do
      nil -> add_error(changeset, :avatar, "Avatar url can't be blank")
      url -> changeset |> change(%{url: url})
    end
  end

  defp validate_avatar_format(changeset, _), do: changeset
end
