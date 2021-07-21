defmodule SaborBrasileiro.Users.Auth.ValidateCredentials do
  alias Ecto.{Multi, Changeset}
  alias SaborBrasileiro.{User, Repo, Users.Queries, Utils.Generate, TemporaryUserPin}

  def call(params) do
    Multi.new()
    |> Multi.run(:get_by_nickname, fn repo, _ ->
      get_user(repo, params)
    end)
    |> Multi.run(
      :validate_password,
      fn _, %{get_by_nickname: %User{password_hash: user_password}} ->
        validate_password(user_password, params)
      end
    )
    |> Multi.insert(:generate_pin, fn %{get_by_nickname: %User{id: user_id}} ->
      temporary_pin_changeset(user_id)
    end)
    |> run_transaction
  end

  defp get_user(repo, params) do
    case User.changeset_auth(params) do
      %Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Changeset{valid?: true, changes: %{nickname: nickname}} ->
        Queries.get_with(%{"nickname" => nickname})
        |> repo.one()
        |> handle_user
    end
  end

  defp temporary_pin_changeset(user_id) do
    pin = Generate.random_n_char_number_string(6)

    %{user_id: user_id, pin: pin}
    |> TemporaryUserPin.changeset()
  end

  defp handle_user(%User{} = user), do: {:ok, user}
  defp handle_user(_), do: {:error, "User not exists"}

  defp validate_password(user_password, %{"password" => password}) do
    case Pbkdf2.verify_pass(password, user_password) do
      true ->
        {:ok, nil}

      false ->
        {:error, "Password has don't match with user password"}
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{get_by_nickname: user, generate_pin: pin}} -> {:ok, user, pin}
    end
  end
end
