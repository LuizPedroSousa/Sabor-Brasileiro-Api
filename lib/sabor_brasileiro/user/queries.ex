defmodule SaborBrasileiro.Users.Queries do
  import Ecto.Query
  alias Ecto.{Multi}
  alias SaborBrasileiro.{User}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(u in User)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"order", "desc"}, query) do
    order_by(query, [u], desc: [u.inserted_at])
  end

  defp compose_query({"order", "asc"}, query) do
    order_by(query, [u], asc: [u.inserted_at])
  end

  defp compose_query({"_limit", limit_c}, query) do
    limit(query, ^limit_c)
  end

  defp compose_query({"name", name}, query) do
    name_like = "%#{name}%"
    where(query, [u], ilike(u.name, ^name_like))
  end

  defp compose_query({"email", email}, query) do
    where(query, [u], u.email == ^email)
  end

  defp compose_query({"nickname", nickname}, query) do
    where(query, [u], u.nickname == ^nickname)
  end

  defp compose_query({"id", id}, query) do
    where(query, [u], u.id == ^id)
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  def preload_data(multi, key) do
    multi
    |> Multi.run(:preload_user_data, fn repo, map ->
      {:ok,
       repo.preload(map[key], [
         :user_avatar
       ])}
    end)
  end
end
