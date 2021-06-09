defmodule SaborBrasileiro do
  alias SaborBrasileiro.Users.Create, as: UserCreate
  alias SaborBrasileiro.Users.Preload, as: UserPreload
  alias SaborBrasileiro.Cakes.Create, as: CakeCreate
  alias SaborBrasileiro.Cakes.Preload, as: CakePreload
  # Cakes
  defdelegate create_cake(params), to: CakeCreate, as: :call
  defdelegate preload_cake_data(multi, key), to: CakePreload, as: :call

  # Users
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate preload_user_data(multi, key), to: UserPreload, as: :call
end
