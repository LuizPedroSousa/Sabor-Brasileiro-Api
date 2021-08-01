defmodule SaborBrasileiro.Users.Availables.CheckNickname do
  alias SaborBrasileiro.{Repo, Users.Queries}

  alias SaborBrasileiro.Users.Availables.CheckNickname.Response,
    as: CheckUserNicknameResponse

  def call(%{"nickname" => nickname}) do
    IO.inspect(nickname)

    Queries.get_with(%{"nickname" => nickname})
    |> Repo.all()
    |> handle_nickname
  end

  def call(_), do: {:ok, %{isNicknameAvailable: false}}

  defp handle_nickname([]), do: {:ok, %CheckUserNicknameResponse{isNicknameAvailable: true}}
  defp handle_nickname(_), do: {:ok, %CheckUserNicknameResponse{isNicknameAvailable: false}}
end
