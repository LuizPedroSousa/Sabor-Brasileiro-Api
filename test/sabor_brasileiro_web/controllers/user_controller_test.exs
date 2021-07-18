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

    test "when all user params are blank, returns an error", %{conn: conn} do
      params = %{}

      response =
        conn
        |> post(Routes.user_path(conn, :create_user, params))
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "email" => ["can't be blank"],
          "name" => ["can't be blank"],
          "nickname" => ["can't be blank"],
          "password" => ["can't be blank"],
          "surname" => ["can't be blank"]
        }
      }

      assert expected_response == response
    end

    test "when user password is less than six characters, returns an error", %{conn: conn} do
      params = %{
        name: Person.PtBr.first_name(),
        surname: Person.PtBr.last_name(),
        email: Internet.email(),
        nickname: Internet.user_name(),
        password: "12345",
      }

      response =
        conn
        |> post(Routes.user_path(conn, :create_user, params))
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert expected_response == response
    end

    test "when user nickname is less than four characters, returns an error", %{conn: conn} do
      params = %{
        name: Person.PtBr.first_name(),
        surname: Person.PtBr.last_name(),
        email: Internet.email(),
        password: "123456",
        nickname: "123"
      }

      response =
        conn
        |> post(Routes.user_path(conn, :create_user, params))
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "nickname" => ["should be at least 4 character(s)"]
        }
      }

      assert expected_response == response
    end

    test "when user email is malformated, returns an error", %{conn: conn} do
      params = %{
        name: Person.PtBr.first_name(),
        surname: Person.PtBr.last_name(),
        nickname: Internet.user_name(),
        email: "test.com",
        password: "123456"
      }

      response =
        conn
        |> post(Routes.user_path(conn, :create_user, params))
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"email" => ["has invalid format"]}}

      assert expected_response == response
    end

    test "when user email already exists, returns an error", %{conn: conn} do
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

      Users.Create.call(params)

      response =
        conn
        |> post(Routes.user_path(conn, :create_user, params))
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"email" => ["has already been taken"]}}
      assert expected_response == response
    end

    test "when user nickname already exists, returns an error", %{conn: conn} do
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

      Users.Create.call(params)

      # Delete old email and put new, to just catch nickname error
      new_params =
        Map.delete(params, "email")
        |> Map.put("email", Internet.email())

      response =
        conn
        |> post(Routes.user_path(conn, :create_user, new_params))
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"nickname" => ["has already been taken"]}}
      assert expected_response == response
    end
  end
end
