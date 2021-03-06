defmodule SaborBrasileiroWeb.UserViewTest do
  use SaborBrasileiroWeb.ConnCase, async: true
  import Phoenix.View

  alias Faker.{Person, Internet, Avatar}
  alias SaborBrasileiroWeb.UserView
  alias SaborBrasileiro.{User, UserAvatar}

  setup do
    create_user()
  end

  test "renders create_user.json", %{
    user:
      %User{
        id: user_id,
        name: name,
        surname: surname,
        email: email,
        nickname: nickname,
        inserted_at: user_inserted_at,
        user_avatar: %UserAvatar{id: avatar_id, url: avatar_url, inserted_at: avatar_inserted_at}
      } = user
  } do
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

  test "renders authenticate_user.json", %{
    user:
      %User{
        id: user_id,
        name: name,
        surname: surname,
        email: email,
        nickname: nickname,
        inserted_at: user_inserted_at,
        user_avatar: %UserAvatar{id: avatar_id, url: avatar_url, inserted_at: avatar_inserted_at}
      } = user
  } do
    response = render(UserView, "authenticate_user.json", user: user)

    expected_response = %{
      ok: "User authenticated with successfully",
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

  defp create_user do
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

    {:ok, %User{} = user} = SaborBrasileiro.create_user(params)
    %{user: user, params: params}
  end
end
