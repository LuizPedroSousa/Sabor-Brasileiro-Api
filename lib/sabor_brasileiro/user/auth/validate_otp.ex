defmodule SaborBrasileiro.Users.Auth.ValidateOTP do
  alias Ecto.{Multi}

  alias SaborBrasileiro.{
    User,
    Repo,
    UserOTP,
    Users.Queries,
    Utils.TokenUtils,
    RefreshToken
  }

  alias SaborBrasileiro.Users.Auth.ValidateUserOTP.Response, as: ValidateResponse

  def call(params) do
    Multi.new()
    |> Multi.run(:get_otp, fn repo, _ ->
      get_user_otp(repo, params)
    end)
    |> Multi.delete_all(:delete_otps, fn %{get_otp: %UserOTP{user_id: user_id}} ->
      UserOTP.Queries.get_with(%{"user_id" => user_id})
    end)
    |> Multi.run(:get_user, fn repo, %{get_otp: %UserOTP{user_id: user_id}} ->
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

  defp get_user_otp(repo, %{"code" => code}) do
    UserOTP.Queries.get_with(%{"otp_code" => code})
    |> repo.one
    |> handle_otp
    |> validate_otp_expiration
  end

  defp get_user_otp(_repo, _), do: {:error, %{code: ["can't be blank"]}}

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

  defp validate_otp_expiration(%UserOTP{otp_code: otp_code, otp_secret: otp_secret} = otp) do
    otp_code
    |> OneTimePassEcto.Base.check_totp(otp_secret, interval_length: 600)
    |> validate_otp_expiration(otp)
  end

  defp validate_otp_expiration(error), do: error

  defp validate_otp_expiration(false, _), do: {:error, "Code expired"}
  defp validate_otp_expiration(_, otp), do: {:ok, otp}

  defp handle_otp(%UserOTP{} = otp), do: otp
  defp handle_otp(_), do: {:error, "Code not found"}

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
