defmodule SaborBrasileiroWeb.Plugs.CheckUUID do
  import Plug.Conn
  alias SaborBrasileiro.Utils.Id

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    id_list = conn.path_params["id"] |> String.split(",")

    case Id.validate_ids(id_list) do
      :ok -> conn
      _ -> put_error(conn, opts)
    end
  end

  defp put_error(conn, _opts) do
    conn
    |> send_resp(:bad_request, "Invalid path params")
    |> halt
  end
end
