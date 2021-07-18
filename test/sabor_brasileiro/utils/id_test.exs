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

  describe "validate_ids/1" do
    test "when uuid list are valid, returns an :ok atom" do
      uuid_list = [UUID.generate(), UUID.generate()]

      validate_ids = Id.validate_ids(uuid_list)

      assert :ok = validate_ids
    end

    test "when uuid list are invalid, return an error" do
      uuid_list = [UUID.generate(), "444456-5656565-6656"]

      validate_ids = Id.validate_ids(uuid_list)

      assert {:error, "Invalid uuid"} = validate_ids
    end
  end
end
