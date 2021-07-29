defmodule SaborBrasileiroWeb.CakeControllerTest do
  use SaborBrasileiroWeb.ConnCase, async: true
  alias Faker.{Food, Avatar}
  alias SaborBrasileiro.{Cake, CakeCategory}

  describe "create_cake/2" do
    test "when all cake params are valid, create a cake", %{conn: conn} do
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

      %{
        "name" => name,
        "description" => description,
        "kg" => kg,
        "stars" => stars,
        "price" => price
      } = params

      response =
        conn
        |> post(Routes.cake_path(conn, :create_cake, params))
        |> json_response(:created)

      expected_response = %{
        "ok" => "Cake created with successfully",
        "cake" => %{
          "category" => "Bolos caseiros",
          "description" => description,
          "id" => response["cake"]["id"],
          "ingredients" => response["cake"]["ingredients"],
          "inserted_at" => response["cake"]["inserted_at"],
          "kg" => kg,
          "name" => name,
          "photos" => response["cake"]["photos"],
          "price" => price,
          "slug" => response["cake"]["slug"],
          "stars" => stars
        }
      }

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
