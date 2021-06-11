defmodule SaborBrasileiroWeb.BestConfectionerController do
  use SaborBrasileiroWeb, :controller
  alias SaborBrasileiro.{BestConfectioner}
  import SaborBrasileiro, only: [create_best_confectioner: 1]
  action_fallback SaborBrasileiroWeb.FallbackController

  def create(conn, params) do
    %{"id" => id} = params

    with {:ok, %BestConfectioner{} = best_confectioner} <- create_best_confectioner(id) do
      conn
      |> put_status(:created)
      |> render("create.json", best_confectioner: best_confectioner)
    end
  end
end
