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
