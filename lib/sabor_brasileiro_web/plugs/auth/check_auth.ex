defmodule SaborBrasileiroWeb.Plugs.Auth.CheckAuth do
  import Plug.Conn

  alias SaborBrasileiro.Utils.TokenUtils

  def init(opts) do
    opts
  end

  def call(conn = %{req_headers: req_headers}, opts) do
    access_token = :proplists.get_value("x-access-token", req_headers, nil)
    refresh_token = :proplists.get_value("x-refresh-token", req_headers, nil)

    if access_token && refresh_token do
      assign_tokens(conn, access_token, refresh_token, opts)
    else
      auth_error(conn, opts)
    end
  end

  defp assign_tokens(conn, access_token, refresh_token, opts) do
    case TokenUtils.tokens_to_user_id(access_token, refresh_token) do
      nil ->
        auth_error(conn, opts)

      {:existing_claim, user_id} ->
        assign(conn, :user_id, user_id)

      {:new_tokens, user_id, %{access_token: new_access_token, refresh_token: new_refresh_token},
       user} ->
        conn
        |> put_resp_header(
          "X-Access-Token",
          new_access_token
        )
        |> put_resp_header(
          "X-Refresh-Token",
          new_refresh_token
        )
        |> assign(:user_id, user_id)
        |> assign(:user, user)
    end
  end

  defp auth_error(conn, _opts) do
    conn
    |> send_resp(400, "Not authenticated")
    |> halt
  end
end
