defmodule SaborBrasileiro.Users.Auth.ValidateCredentials.Response do
  defstruct [:user, :user_otp]
  alias SaborBrasileiro.{User, UserOTP}

  def build(%User{} = user, %UserOTP{} = user_otp) do
    %__MODULE__{
      user: user,
      user_otp: user_otp
    }
  end
end
