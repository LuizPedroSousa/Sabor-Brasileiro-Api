defmodule SaborBrasileiro.FAQSolicitation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name, :surname, :subject, :email, :reason, :description]

  schema "faq_solicitations" do
    field :name, :string
    field :surname, :string
    field :email, :string
    field :subject, :string
    field :reason, :string, default: "outros"
    field :description, :string
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
  end
end
