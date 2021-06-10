defmodule SaborBrasileiro.CakeCategories.Create do
  alias SaborBrasileiro.{Repo, CakeCategory}

  def call(params) do
    CakeCategory.changeset(params)
    |> Repo.insert()
  end
end
