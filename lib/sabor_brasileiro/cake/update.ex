defmodule SaborBrasileiro.Cakes.Update do
  alias Ecto.{Multi}
  alias SaborBrasileiro.{Cake, Repo}
  import SaborBrasileiro, only: [preload_cake_data: 2]

  def call(id, params) do
    Multi.new()
    |> Multi.run(:find_cake, fn repo, _ ->
      find_cake(repo, id)
    end)
    |> Multi.update(:update_cake, fn %{find_cake: cake} ->
      cake_changeset(cake, params)
    end)
    |> preload_cake_data(:update_cake)
    |> run_transaction
  end

  defp find_cake(repo, id) do
    case repo.get_by(Cake, %{id: id}) do
      nil -> {:error, "Cake not found"}
      %Cake{} = cake -> {:ok, cake}
    end
  end

  defp cake_changeset(cake, params) do
    data = for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}
    Cake.changeset_update(cake, data)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: cake}} -> {:ok, cake}
    end
  end
end
