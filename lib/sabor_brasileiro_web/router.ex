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
    post "/create", UserController, :create_user
    post "/auth", UserController, :auth_user_credentials
  end

  # BestConfectioner
  scope "/best_confectioners", SaborBrasileiroWeb do
    pipe_through :api
    get "/", BestConfectionerController, :index
    post "/create", BestConfectionerController, :create
    delete "/delete/:id", BestConfectionerController, :delete
  end

  # Cake
  scope "/cakes", SaborBrasileiroWeb do
    pipe_through :api
    get "/", CakeController, :find_cakes
    delete "/delete/:id", CakeController, :delete_cake
    post "/create", CakeController, :create_cake
    put "/update/:slug", CakeController, :update_cake
    get "/show/:slug", CakeController, :show_cake

    # Cake Categories
    get "/categories", CakeController, :find_cake_categories
    post "/categories/create", CakeController, :create_cake_category
    put "/categories/update/:id", CakeController, :update_cake_category
    delete "/categories/delete/:id", CakeController, :delete_cake_categories

    # Cake Photos
    put "/photos/update/:id", CakeController, :update_cake_photo
  end

  # FAQ
  scope "/faq", SaborBrasileiroWeb do
    pipe_through :api

    # Solicitations

    options "/solicitations/create", FAQController, :create_solicitation
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

  if Mix.env() in [:dev] do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SaborBrasileiroWeb.Telemetry
    end
  end
end
