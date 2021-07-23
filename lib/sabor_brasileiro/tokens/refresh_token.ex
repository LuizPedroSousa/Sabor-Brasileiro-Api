defmodule SaborBrasileiro.Tokens.RefreshToken do
  def __default_signer__,
    do:
      Joken.Signer.create(
        "HS256",
        Application.fetch_env!(:sabor_brasileiro, :refresh_token_secret)
      )

  use Joken.Config

  # 14 days
  def token_config, do: default_claims(default_exp: 60 * 60 * 24 * 14)
end
