defmodule SaborBrasileiro.Users.CreateTest do
  use SaborBrasileiro.DataCase
  alias SaborBrasileiro.{User, Users.Create, Repo, UserAvatar}
  alias Faker.{Person, Internet, Avatar}

  describe "call/1" do
    test "when all user params are valid, return an user" do
      params = %{
        "name" => Person.PtBr.first_name(),
        "surname" => Person.PtBr.last_name(),
        "nickname" => Internet.user_name(),
        "email" => Internet.email(),
        "password" => "12345678",
        "avatar" => %{
          "url" => Avatar.image_url()
        }
      }

      {:ok, %User{id: user_id, password_hash: password_hash}} = Create.call(params)

      user = Repo.get(User, user_id) |> Repo.preload([:user_avatar])

      %{
        "name" => name,
        "surname" => surname,
        "email" => email,
        "nickname" => nickname,
        "avatar" => %{"url" => avatar_url},
        "password" => password
      } = params

      assert %User{
               id: ^user_id,
               name: ^name,
               surname: ^surname,
               email: ^email,
               nickname: ^nickname,
               user_avatar: %UserAvatar{
                 url: ^avatar_url
               }
             } = user

      assert true = Pbkdf2.verify_pass(password, password_hash)
    end

    test "when all user params are blank, returns an error" do
      params = %{}

      {:error, changeset} = Create.call(params)

      expected_response = %{
        email: ["can't be blank"],
        name: ["can't be blank"],
        nickname: ["can't be blank"],
        password: ["can't be blank"],
        surname: ["can't be blank"]
      }

      assert expected_response == errors_on(changeset)
    end

    test "when user avatar url are blank, returns an error" do
      params = %{
        "name" => Person.PtBr.first_name(),
        "surname" => Person.PtBr.last_name(),
        "nickname" => Internet.user_name(),
        "email" => Internet.email(),
        "password" => "12345678",
        "avatar" => %{}
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{avatar: ["Avatar url can't be blank"]}

      assert expected_response == errors_on(changeset)
    end

    test "when user password is less than six characters, returns an error" do
      params = %{
        name: Person.PtBr.first_name(),
        surname: Person.PtBr.last_name(),
        nickname: Internet.user_name(),
        email: Internet.email(),
        password: "12345"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{password: ["should be at least 6 character(s)"]}

      assert expected_response == errors_on(changeset)
    end

    test "when user nickname is less than four characters, returns an error" do
      params = %{
        name: Person.PtBr.first_name(),
        surname: Person.PtBr.last_name(),
        email: Internet.email(),
        password: "123456",
        nickname: "123"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{nickname: ["should be at least 4 character(s)"]}

      assert expected_response == errors_on(changeset)
    end

    test "when user email is malformated, returns an error" do
      params = %{
        name: Person.PtBr.first_name(),
        surname: Person.PtBr.last_name(),
        nickname: Internet.user_name(),
        email: "test.com",
        password: "123456"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{email: ["has invalid format"]}

      assert expected_response == errors_on(changeset)
    end

    test "when user email alredy exists, returns an error" do
      params = %{
        "name" => Person.first_name(),
        "surname" => Person.last_name(),
        "nickname" => Internet.user_name(),
        "email" => Internet.email(),
        "password" => "121231234",
        "avatar" => %{
          "url" => Avatar.image_url()
        }
      }

      Create.call(params)

      {:error, changeset} = Create.call(params)
      expected_response = %{email: ["has already been taken"]}
      assert expected_response == errors_on(changeset)
    end

    test "when user nickname already exists, returns an error" do
      params = %{
        "name" => Person.first_name(),
        "surname" => Person.last_name(),
        "nickname" => Internet.user_name(),
        "email" => Internet.email(),
        "password" => "121231234",
        "avatar" => %{
          "url" => Avatar.image_url()
        }
      }

      Create.call(params)

      # Delete old email and put new, to just catch nickname error
      new_params =
        Map.delete(params, "email")
        |> Map.put("email", Internet.email())

      {:error, changeset} = Create.call(new_params)
      expected_response = %{nickname: ["has already been taken"]}
      assert expected_response == errors_on(changeset)
    end
  end
end
