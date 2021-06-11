defmodule SaborBrasileiroWeb.Router do
  use SaborBrasileiroWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SaborBrasileiroWeb do
    pipe_through :api
  end

  # User
  scope "/users", SaborBrasileiroWeb do
    pipe_through :api
    post "/create", UserController, :create
  end

  # Cake
  scope "/cakes", SaborBrasileiroWeb do
    pipe_through :api
    get "/", CakeController, :index
    post "/create", CakeController, :create
    put "/update/:id", CakeController, :update
  end

  # BestConfectioner
  scope "/best_confectioners", SaborBrasileiroWeb do
    pipe_through :api
    get "/", BestConfectionerController, :index
    post "/create", BestConfectionerController, :create
  end

  # Cake Categories
  scope "/cakes/categories", SaborBrasileiroWeb do
    pipe_through :api
    get "/", CakeCategoryController, :index
    post "/create", CakeCategoryController, :create
    put "/update/:id", CakeCategoryController, :update
    delete "/delete/:id", CakeCategoryController, :delete
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SaborBrasileiroWeb.Telemetry
    end
  end
end
