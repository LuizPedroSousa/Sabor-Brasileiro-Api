alias SaborBrasileiro.{Repo, User, UserAvatar}
alias Ecto.Changeset

user_params = %{
  "name" => "Crispim Borges",
  "surname" => "Lemos",
  "email" => "crispimborges@gmail.com",
  "password" => "123456",
  "nickname" => "crispimborges"
}

user_avatar_params = %{
  "avatar" => %{
    "url" =>
      "https://scontent.fcgh37-1.fna.fbcdn.net/v/t1.6435-9/75588105_10212710874201644_8796001797102632960_n.jpg?_nc_cat=101&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=AO5XpWOWO0MAX9mq9k3&_nc_ht=scontent.fcgh37-1.fna&oh=460ecae06da142dc792108ef4ed03740&oe=6122D61F"
  }
}

%User{id: user_id} =
  user_params
  |> User.changeset()
  |> Repo.insert!()
  |> Changeset.change(%{isAdmin: true})
  |> Repo.update!()

user_avatar_params
|> Map.merge(%{"user_id" => user_id})
|> UserAvatar.changeset()
|> Repo.insert!()
