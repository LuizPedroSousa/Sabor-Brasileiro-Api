defmodule SaborBrasileiro.Users.Auth.ValidateUserOTP.Response do
  defstruct [:user, :tokens]

  alias SaborBrasileiro.{User}

  def build(%User{} = user, %{access_token: access_token, refresh_token: refresh_token}) do
    %__MODULE__{
      user: user,
      tokens: %{
        access_token: access_token,
        refresh_token: refresh_token
      }
    }
  end
end
