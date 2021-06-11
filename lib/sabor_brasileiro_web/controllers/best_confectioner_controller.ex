defmodule SaborBrasileiroWeb.BestConfectionerController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{BestConfectioner}
  import SaborBrasileiro, only: [create_best_confectioner: 1, get_best_confectioners: 1]
  action_fallback SaborBrasileiroWeb.FallbackController

  def index(conn, _params) do
    query = conn.query_params
    with {:ok, best_confectioners} <- get_best_confectioners(query) do
      conn
      |> put_status(:ok)
      |> render("index.json", best_confectioners: best_confectioners)
    end
  end

  def create(conn, params) do
    %{"id" => id} = params

    with {:ok, %BestConfectioner{} = best_confectioner} <- create_best_confectioner(id) do
      conn
      |> put_status(:created)
      |> render("create.json", best_confectioner: best_confectioner)
    end
  end
end
