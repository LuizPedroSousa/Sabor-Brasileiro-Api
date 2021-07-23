defmodule SaborBrasileiroWeb.Plugs.Auth.CheckAdmin do
  import Plug.Conn
  alias SaborBrasileiro.{User, Users, Repo}

  def init(opts) do
    opts
  end

  def call(%{assigns: assigns} = conn, opts) do
    case Map.has_key?(assigns, :user) do
      true ->
        handle_user(assigns.user, conn, opts)

      _ ->
        Users.Queries.get_with(%{"id" => assigns.user_id})
        |> Repo.one()
        |> handle_user(conn, opts)
    end

    conn
  end

  defp handle_user(%User{isAdmin: true}, conn, _opts), do: conn
  defp handle_user(_user, conn, opts), do: authorization_error(conn, opts)

  defp authorization_error(conn, _opts) do
    conn
    |> send_resp(401, "Not authorized")
    |> halt
  end
end
