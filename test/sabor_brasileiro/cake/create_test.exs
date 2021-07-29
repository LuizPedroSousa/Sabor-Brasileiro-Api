defmodule SaborBrasileiro.Cakes.CreateTest do
  use SaborBrasileiro.DataCase, async: true
  alias Faker.{Food, Avatar}
  alias SaborBrasileiro.{Cake, CakeCategory}

  describe "create_cake/1" do
    test "when all cake params are valid, returns a cake" do
      create_category()

      params = %{
        "name" => Food.PtBr.dish(),
        "category" => "Bolos caseiros",
        "description" => Food.PtBr.description(),
        "kg" => "900",
        "stars" => 4,
        "price" => "24.00",
        "ingredients" => [
          %{
            "name" => Food.PtBr.ingredient()
          },
          %{
            "name" => Food.PtBr.ingredient()
          },
          %{
            "name" => Food.PtBr.ingredient()
          }
        ],
        "photos" => [%{"url" => Avatar.image_url()}]
      }

      %{"name" => name, "category" => category, "description" => description, "kg" => kg} = params

      {:ok,
       %Cake{id: cake_id, cake_category: %CakeCategory{id: category_id, name: ^category}} = cake} =
        SaborBrasileiro.create_cake(params)

      assert %Cake{
               id: ^cake_id,
               name: ^name,
               description: ^description,
               kg: ^kg,
               cake_category_id: ^category_id
             } = cake
    end

    test "when category name are blank, returns an error" do
      {:error, response} = SaborBrasileiro.create_cake(%{})

      expected_response = %{category: ["can't be blank"]}
      assert expected_response == response
    end

    test "when category not exists, returns an error" do
      params = %{
        "category" => "not_existent"
      }

      {:error, response} = SaborBrasileiro.create_cake(params)

      expected_response = "Cake category not found"
      assert expected_response == response
    end

    test "when cake params are blank, returns an error" do
      create_category()

      params = %{
        "category" => "Bolos caseiros"
      }

      {:error, changeset} = SaborBrasileiro.create_cake(params)

      expected_response = %{
        description: ["can't be blank"],
        kg: ["can't be blank"],
        name: ["can't be blank"],
        price: ["can't be blank"]
      }

      assert expected_response == errors_on(changeset)
    end

    test "when cake photos are blank, returns an error" do
      create_category()

      params = %{
        "name" => Food.PtBr.dish(),
        "category" => "Bolos caseiros",
        "description" => Food.PtBr.description(),
        "kg" => "900",
        "stars" => 4,
        "price" => "24.00"
      }

      {:error, response} = SaborBrasileiro.create_cake(params)

      expected_response = %{photos: ["can't be blank"]}
      assert expected_response == response
    end

    test "when cake ingredients are blank, returns an error" do
      create_category()

      params = %{
        "name" => Food.PtBr.dish(),
        "category" => "Bolos caseiros",
        "description" => Food.PtBr.description(),
        "kg" => "900",
        "stars" => 4,
        "price" => "24.00",
        "photos" => [%{"url" => Avatar.image_url()}]
      }

      {:error, response} = SaborBrasileiro.create_cake(params)

      expected_response = %{ingredients: ["can't be blank"]}

      assert expected_response == response
    end
  end

  @type cc :: {:ok, %CakeCategory{}}
  @spec create_category :: cc
  defp create_category do
    category_params = %{
      "name" => "Bolos caseiros"
    }

    SaborBrasileiro.create_cake_category(category_params)
  end
end
