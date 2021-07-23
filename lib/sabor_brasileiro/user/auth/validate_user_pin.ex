defmodule SaborBrasileiro.Users.Auth.ValidateUserPin do
  alias Ecto.{Multi}

  alias SaborBrasileiro.{
    User,
    Repo,
    TemporaryUserPin,
    Users.Queries,
    Utils.TokenUtils,
    RefreshToken
  }

  alias SaborBrasileiro.Users.Auth.ValidateUserPin.Response, as: ValidateResponse

  def call(params) do
    Multi.new()
    |> Multi.run(:get_pin, fn repo, _ ->
      get_temporary_pin(repo, params)
    end)
    |> Multi.delete_all(:delete_pins, fn %{get_pin: %TemporaryUserPin{user_id: user_id}} ->
      TemporaryUserPin.Queries.get_with(%{"user_id" => user_id})
    end)
    |> Multi.run(:get_user, fn repo, %{get_pin: %TemporaryUserPin{user_id: user_id}} ->
      get_user(repo, user_id)
    end)
    |> Multi.run(:create_refresh_token, fn repo, %{get_user: %User{} = user} ->
      create_refresh_token(repo, user)
    end)
    |> Multi.run(
      :generate_tokens,
      fn _,
         %{
           create_refresh_token: %RefreshToken{
             id: refresh_token_id,
             user_id: user_id
           }
         } ->
        generate_tokens(refresh_token_id, user_id)
      end
    )
    |> Queries.preload_data(:get_user)
    |> run_transaction
  end

  defp get_temporary_pin(repo, %{"pin" => pin}) do
    TemporaryUserPin.Queries.get_with(%{"pin" => pin})
    |> repo.one
    |> handle_pin
    |> validate_pin_expiration
  end

  defp get_temporary_pin(_repo, _), do: {:error, %{pin: ["can't be blank"]}}

  defp get_user(repo, user_id) do
    Queries.get_with(%{"id" => user_id})
    |> repo.one()
    |> handle_user
  end

  defp generate_tokens(refresh_token_id, user_id) do
    tokens =
      user_id
      |> TokenUtils.generate_tokens(refresh_token_id)

    {:ok, tokens}
  end

  defp create_refresh_token(repo, user) do
    %User{id: user_id, refresh_token: refresh_token} =
      user
      |> repo.preload(:refresh_token)

    case refresh_token do
      %RefreshToken{} ->
        RefreshToken.changeset(refresh_token, %{})
        |> repo.update

      nil ->
        RefreshToken.changeset(%{user_id: user_id})
        |> repo.insert
    end
  end

  defp validate_pin_expiration(%TemporaryUserPin{expires_in: expires_in} = pin) do
    now =
      Timex.now()
      |> Timex.to_unix()

    case expires_in < now do
      true -> {:error, "Expired pin code"}
      false -> {:ok, pin}
    end
  end

  defp validate_pin_expiration(error), do: error

  defp handle_pin(%TemporaryUserPin{} = pin), do: pin
  defp handle_pin(_), do: {:error, "Pin code not found"}

  defp handle_user(%User{} = user), do: {:ok, user}
  defp handle_user(_), do: {:error, "User not found"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_user_data: user, generate_tokens: tokens}} ->
        {:ok, ValidateResponse.build(user, tokens)}
    end
  end
end
