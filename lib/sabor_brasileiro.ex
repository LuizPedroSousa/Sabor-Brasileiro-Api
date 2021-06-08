defmodule SaborBrasileiro do
  alias SaborBrasileiro.Users.Create, as: UserCreate
  alias SaborBrasileiro.Users.Preload, as: UserPreload
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate preload_user_data(multi, key), to: UserPreload, as: :call
end
