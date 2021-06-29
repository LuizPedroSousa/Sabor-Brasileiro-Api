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
    delete "/delete/:id", CakeController, :delete
    post "/create", CakeController, :create
    put "/update/:id", CakeController, :update
  end

  # BestConfectioner
  scope "/best_confectioners", SaborBrasileiroWeb do
    pipe_through :api
    get "/", BestConfectionerController, :index
    post "/create", BestConfectionerController, :create
    delete "/delete/:id", BestConfectionerController, :delete
  end

  # Cake Categories
  scope "/cakes/categories", SaborBrasileiroWeb do
    pipe_through :api
    get "/", CakeCategoryController, :index
    post "/create", CakeCategoryController, :create
    put "/update/:id", CakeCategoryController, :update
    delete "/delete/:id", CakeCategoryController, :delete
  end

  # FAQ
  scope "/faq", SaborBrasileiroWeb do
    pipe_through :api
    # Solicitations
    post "/solicitations/create", FAQController, :create_solicitation

    # Articles
    get "/articles", FAQController, :find_articles
    post "/articles/create", FAQController, :create_article
    get "/articles/show/:slug", FAQController, :show_article

    # Categories
    get "/articles/categories", FAQController, :find_article_categories
    post "/articles/categories/create", FAQController, :create_article_category
    delete "/articles/categories/delete/:ids", FAQController, :delete_article_categories
    get "/articles/categories/show/:slug", FAQController, :show_article_category
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SaborBrasileiroWeb.Telemetry
    end
  end
end
