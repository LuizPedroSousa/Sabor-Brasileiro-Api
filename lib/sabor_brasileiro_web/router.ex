defmodule SaborBrasileiroWeb.Router do
  use SaborBrasileiroWeb, :router
  alias SaborBrasileiroWeb.Plugs.Auth.{CheckAuth, CheckAdmin}

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
    post "/auth/validate/pin", UserController, :auth_user_pin

    pipe_through [CheckAuth]
    get "/show", UserController, :show_user
  end

  # BestConfectioner
  scope "/best_confectioners", SaborBrasileiroWeb do
    pipe_through :api
    get "/", BestConfectionerController, :index

    pipe_through [CheckAuth, CheckAdmin]
    delete "/delete/:id", BestConfectionerController, :delete
    post "/create", BestConfectionerController, :create
  end

  # Cake
  scope "/cakes", SaborBrasileiroWeb do
    pipe_through :api
    get "/", CakeController, :find_cakes
    get "/show/:slug", CakeController, :show_cake
    get "/categories", CakeController, :find_cake_categories

    get "/ratings", CakeController, :find_cake_ratings

    pipe_through [CheckAuth]
    post "/ratings/create", CakeController, :create_cake_rating

    pipe_through [CheckAdmin]
    delete "/delete/:id", CakeController, :delete_cake
    post "/create", CakeController, :create_cake
    put "/update/:slug", CakeController, :update_cake
    post "/categories/create", CakeController, :create_cake_category
    put "/categories/update/:id", CakeController, :update_cake_category
    delete "/categories/delete/:id", CakeController, :delete_cake_categories
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
    get "/articles/show/:slug", FAQController, :show_article

    # Categories
    get "/articles/categories", FAQController, :find_article_categories
    get "/articles/categories/show/:slug", FAQController, :show_article_category

    pipe_through [CheckAuth, CheckAdmin]
    post "/articles/create", FAQController, :create_article
    delete "/articles/categories/delete/:ids", FAQController, :delete_article_categories
    post "/articles/categories/create", FAQController, :create_article_category
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
