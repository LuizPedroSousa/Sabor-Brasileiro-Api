defmodule SaborBrasileiro.UserOTP.Queries do
  import Ecto.Query
  alias SaborBrasileiro.{UserOTP}

  def get_with(query) do
    base_query()
    |> build_query(query)
  end

  defp base_query() do
    from(uo in UserOTP)
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"order", "desc"}, query) do
    order_by(query, [uo], desc: [uo.inserted_at])
  end

  defp compose_query({"order", "asc"}, query) do
    order_by(query, [uo], asc: [uo.inserted_at])
  end

  defp compose_query({"_limit", limit_c}, query) do
    limit(query, ^limit_c)
  end

  defp compose_query({"user_id", user_id}, query) do
    where(query, [uo], uo.user_id == ^user_id)
  end

  defp compose_query({"otp_code", otp_code}, query) do
    where(query, [uo], uo.otp_code == ^otp_code)
  end
end
