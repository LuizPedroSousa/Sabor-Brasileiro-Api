defmodule SaborBrasileiro.Users.Availables.CheckNickname.Response do
  defstruct [:isNicknameAvailable]

  def build(%{isNicknameAvailable: isNicknameAvailable}) do
    %__MODULE__{
      isNicknameAvailable: isNicknameAvailable
    }
  end
end
