defmodule SaborBrasileiro.Cakes.GetAll do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake, Repo}
  import SaborBrasileiro, only: [preload_cake_data: 2]

  def call() do
    Multi.new()
    |> Multi.run(:get_all_cakes, fn repo, _ ->
      get_all(repo)
    end)
    |> preload_cake_data(:get_all_cakes)
    |> run_transaction
  end

  defp get_all(repo) do
    cakes = Cake |> repo.all()
    {:ok, cakes}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: cake}} -> {:ok, cake}
    end
  end
end
