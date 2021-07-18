defmodule SaborBrasileiro.Utils.IdTest do
  use ExUnit.Case, async: true
  alias Ecto.UUID
  alias SaborBrasileiro.Utils.Id

  describe "validate_id/1" do
    test "when uuid are valid, returns an :ok atom" do
      uuid = UUID.generate()
      validate_id = Id.validate_id(uuid)

      assert :ok = validate_id
    end

    test "when uuid are invalid, return an error" do
      uuid = "4564564-4564564-45645-456464"
      validate_id = Id.validate_id(uuid)

      assert {:error, "Invalid uuid"} = validate_id
    end
  end
end
