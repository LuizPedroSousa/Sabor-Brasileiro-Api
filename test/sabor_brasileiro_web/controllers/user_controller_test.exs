defmodule SaborBrasileiroWeb.UserControllerTest do
  use SaborBrasileiroWeb.ConnCase
  alias Faker.{Person, Internet, Avatar}
  alias SaborBrasileiro.{Users}

  describe "create_user/2" do
    test "when all user params are valid, create a user", %{conn: conn} do
      params = %{
        "name" => Person.first_name(),
        "surname" => Person.last_name(),
        "email" => Internet.email(),
        "nickname" => Internet.user_name(),
        "password" => "121231234",
        "avatar" => %{
          "url" => Avatar.image_url()
        }
      }

      response =
        conn
        |> post(Routes.user_path(conn, :create_user, params))
        |> json_response(:created)

      expected_response = %{
        "ok" => "user created with successfully",
        "user" => %{
          "avatar" => %{
            "id" => response["user"]["avatar"]["id"],
            "inserted_at" => response["user"]["avatar"]["inserted_at"],
            "url" => response["user"]["avatar"]["url"],
            "user_id" => response["user"]["id"]
          },
          "email" => response["user"]["email"],
          "nickname" => response["user"]["nickname"],
          "id" => response["user"]["id"],
          "inserted_at" => response["user"]["inserted_at"],
          "name" => response["user"]["name"],
          "surname" => response["user"]["surname"]
        }
      }

      assert expected_response == response
    end
  end
end
