defmodule SaborBrasileiro.Utils.TokenUtils do
  alias SaborBrasileiro.{Tokens, RefreshToken, Repo, RefreshTokens}

  def tokens_to_user_id(access_token, refresh_token) do
    access_token = access_token || ""

    case Tokens.AccessToken.verify_and_validate(access_token) do
      {:ok, claims} ->
        {:existing_claim, claims["user_id"]}

      _ ->
        verify_refresh_token(refresh_token)
    end
  end

  defp verify_refresh_token(refresh_token) do
    refresh_token = refresh_token || ""

    case Tokens.RefreshToken.verify_and_validate(refresh_token) do
      {:ok, %{"refresh_token_id" => refresh_token_id}} ->
        refresh =
          RefreshTokens.Queries.get_with(%{"id" => refresh_token_id})
          |> Repo.one()
          |> Repo.preload([:user, user: :user_avatar])

        if refresh && refresh.user do
          {:new_tokens, refresh.user.id, generate_tokens(refresh), refresh.user}
        end

      # if user &&
      #      user.tokenVersion == refreshClaims["tokenVersion"] do
      #   {:new_tokens, user.id, create_tokens(user), user}
      # end

      _ ->
        nil
    end
  end

  def generate_tokens(user_id, refresh_token_id) do
    %{
      access_token: Tokens.AccessToken.generate_and_sign!(%{"user_id" => user_id}),
      refresh_token:
        Tokens.RefreshToken.generate_and_sign!(%{
          "refresh_token_id" => refresh_token_id
        })
    }
  end

  defp generate_tokens(%RefreshToken{id: refresh_token_id, user_id: user_id} = refresh_token) do
    RefreshToken.changeset(refresh_token, %{})
    |> Repo.update()

    generate_tokens(user_id, refresh_token_id)
  end
end
