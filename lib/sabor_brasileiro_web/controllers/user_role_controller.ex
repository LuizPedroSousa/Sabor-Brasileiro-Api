defmodule SaborBrasileiroWeb.UserRoleController do
  use SaborBrasileiroWeb, :controller

  alias SaborBrasileiro.{User}
  action_fallback SaborBrasileiroWeb.FallbackController

  def find_best_confectioners(conn, _params) do
    with {:ok, best_confectioners} <- SaborBrasileiro.find_best_confectioners(conn.query_params) do
      conn
      |> put_status(:ok)
      |> render("find_best_confectioners.json", best_confectioners: best_confectioners)
    end
  end

  def create_best_confectioner(conn, params) do
    with {:ok, %User{} = user} <-
           SaborBrasileiro.create_best_confectioner(params) do
      conn
      |> put_status(:ok)
      |> render("create_best_confectioner.json", user: user)
    end
  end
end
