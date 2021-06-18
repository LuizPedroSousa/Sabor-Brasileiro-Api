defmodule SaborBrasileiro.Utils.Id do
  alias Ecto.{UUID}

  def validate_id(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid uuid"}
      {:ok, _} -> :ok
    end
  end

  def validate_ids(ids) do
    idList =
      ids
      |> Enum.map(fn id ->
        case validate_id(id) do
          :ok -> id
          error -> error
        end
      end)

    case Enum.member?(idList, {:error, "Invalid uuid"}) do
      true -> {:error, "Invalid uuid"}
      false -> :ok
    end
  end
end
