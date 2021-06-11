defmodule SaborBrasileiro.BestConfectioners.Create do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Repo, User, BestConfectioner}
  import SaborBrasileiro.Users.Queries, only: [get_confectioner_by_id: 2]
  import SaborBrasileiro, only: [preload_best_confectioner: 2]
  import SaborBrasileiro.Utils.Id, only: [validate_id: 1]

  def call(id) do
    case validate_id(id) do
      {:error, reason} ->
        {:error, reason}

      :ok ->
        Multi.new()
        |> get_confectioner_by_id(id)
        |> Multi.run(:create_best_confectioner, fn repo, %{preload_data: %User{id: user_id}} ->
          BestConfectioner.changeset(%{user_id: user_id})
          |> repo.insert()
        end)
        |> preload_best_confectioner(:create_best_confectioner)
        |> run_transaction
    end
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_best_confectioner_data: best_confectioner}} -> {:ok, best_confectioner}
    end
  end
end
