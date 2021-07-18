defmodule SaborBrasileiro.Users.CreateTest do
  use SaborBrasileiro.DataCase
  alias SaborBrasileiro.{User, Users.Create, Repo, UserAvatar}
  alias Faker.{Person, Internet, Avatar}

  describe "call/1" do
    test "when all user params are valid, return an user" do
      params = %{
        "name" => Person.PtBr.first_name(),
        "surname" => Person.PtBr.last_name(),
        "email" => Internet.email(),
        "password" => "12345678",
        "avatar" => %{
          "url" => Avatar.image_url()
        }
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id) |> Repo.preload([:user_avatar])

      %{
        "name" => name,
        "surname" => surname,
        "email" => email,
        "avatar" => %{"url" => avatar_url}
      } = params

      assert %User{
               id: ^user_id,
               name: ^name,
               surname: ^surname,
               email: ^email,
               user_avatar: %UserAvatar{
                 url: ^avatar_url
               }
             } = user
    end
end
