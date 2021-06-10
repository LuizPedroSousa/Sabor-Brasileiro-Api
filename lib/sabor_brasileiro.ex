defmodule SaborBrasileiro do
  # Users
  alias SaborBrasileiro.Users.Create, as: UserCreate
  alias SaborBrasileiro.Users.Preload, as: UserPreload

  # Cakes
  alias SaborBrasileiro.Cakes.Create, as: CakeCreate
  alias SaborBrasileiro.Cakes.GetAll, as: CakeAll
  alias SaborBrasileiro.Cakes.Preload, as: CakePreload
  alias SaborBrasileiro.Cakes.Update, as: CakeUpdate

  # Cakes Categories
  alias SaborBrasileiro.CakeCategories.Create, as: CategoryCreate
  alias SaborBrasileiro.CakeCategories.Preload, as: CategoryPreload
  alias SaborBrasileiro.CakeCategories.Find, as: CategoryFind
  alias SaborBrasileiro.CakeCategories.Delete, as: CategoryDelete
  alias SaborBrasileiro.CakeCategories.Update, as: CategoryUpdate

  # Cakes Categories
  defdelegate create_cake_category(params), to: CategoryCreate, as: :call
  defdelegate preload_category(multi, key), to: CategoryPreload, as: :call
  defdelegate update_category(id, params), to: CategoryUpdate, as: :call
  defdelegate get_categories(query), to: CategoryFind, as: :call
  defdelegate delete_category(id), to: CategoryDelete, as: :call

  # Cakes
  defdelegate create_cake(params), to: CakeCreate, as: :call
  defdelegate get_all_cakes(), to: CakeAll, as: :call
  defdelegate preload_cake_data(multi, key), to: CakePreload, as: :call
  defdelegate update_cake(id, params), to: CakeUpdate, as: :call

  # Users
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate preload_user_data(multi, key), to: UserPreload, as: :call
end
