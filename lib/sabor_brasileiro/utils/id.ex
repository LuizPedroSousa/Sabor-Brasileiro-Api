defmodule SaborBrasileiro.Utils.Id do
  alias Ecto.{UUID}
  def validate_id(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid uuid"}
      {:ok, _} -> :ok
    end
  end
end
