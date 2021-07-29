defmodule SaborBrasileiro.UserRoles.BestConfectioners.Queries do
  import Ecto.Query

  alias SaborBrasileiro.{User}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(bc in User,
      where: bc.isBestConfectioner == true
    )
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"order", "desc"}, query) do
    order_by(query, [bc], desc: [bc.inserted_at])
  end

  defp compose_query({"order", "asc"}, query) do
    order_by(query, [bc], asc: [bc.inserted_at])
  end

  defp compose_query({"_limit", limit_c}, query) do
    limit(query, ^limit_c)
  end

  defp compose_query({"name", name}, query) do
    name_like = "%#{name}%"
    where(query, [bc], ilike(bc.name, ^name_like))
  end

  defp compose_query({"email", email}, query) do
    where(query, [bc], bc.email == ^email)
  end

  defp compose_query({"isBestConfectioner", isBestConfectioner}, query) do
    where(query, [bc], bc.isBestConfectioner == ^isBestConfectioner)
  end

  defp compose_query({"nickname", nickname}, query) do
    where(query, [bc], bc.nickname == ^nickname)
  end

  defp compose_query({"id", id}, query) do
    where(query, [bc], bc.id == ^id)
  end

  defp compose_query(_unsupported_param, query) do
    query
  end
end
