defmodule SaborBrasileiroWeb.UserViewTest do
  use SaborBrasileiroWeb.ConnCase, async: true
  import Phoenix.View

  alias Faker.{Person, Internet, Avatar}
  alias SaborBrasileiroWeb.UserView
  alias SaborBrasileiro.{User, UserAvatar}

  test "renders create_user.json" do
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

    {:ok,
     %User{
       id: user_id,
       email: email,
       name: name,
       surname: surname,
       nickname: nickname,
       inserted_at: user_inserted_at,
       user_avatar: %UserAvatar{
         id: avatar_id,
         url: avatar_url,
         inserted_at: avatar_inserted_at
       }
     } = user} = SaborBrasileiro.create_user(params)

    response = render(UserView, "create_user.json", user: user)

    expected_response = %{
      ok: "user created with successfully",
      user: %{
        avatar: %{
          id: avatar_id,
          inserted_at: avatar_inserted_at,
          url: avatar_url,
          user_id: user_id
        },
        email: email,
        id: user_id,
        inserted_at: user_inserted_at,
        name: name,
        nickname: nickname,
        surname: surname
      }
    }

    assert expected_response == response
  end
end
