defmodule SaborBrasileiro do
  # Users
  alias SaborBrasileiro.Users.Create, as: UserCreate
  alias SaborBrasileiro.Users.Show, as: UserShow
  alias SaborBrasileiro.Users.Auth.ValidateCredentials, as: UserAuthCredentials
  alias SaborBrasileiro.Users.Auth.ValidateOTP, as: UserAuthOTP

  alias SaborBrasileiro.Users.Availables.CheckNickname, as: UserCheckNickname

  # Cakes
  alias SaborBrasileiro.Cakes.Create, as: CakeCreate
  alias SaborBrasileiro.Cakes.Show, as: CakeShow
  alias SaborBrasileiro.Cakes.Find, as: CakeFind
  alias SaborBrasileiro.Cakes.Update, as: CakeUpdate
  alias SaborBrasileiro.Cakes.Delete, as: CakeDelete

  # Cakes Categories
  alias SaborBrasileiro.CakeCategories.Create, as: CategoryCreate
  alias SaborBrasileiro.CakeCategories.Find, as: CategoryFind
  alias SaborBrasileiro.CakeCategories.Delete, as: CategoryDelete
  alias SaborBrasileiro.CakeCategories.Update, as: CategoryUpdate

  # Cakes Photos
  alias SaborBrasileiro.CakePhotos.Update, as: CakePhotoUpdate

  # Cake Ratings
  alias SaborBrasileiro.CakeRatings.Create, as: CakeRatingCreate
  alias SaborBrasileiro.CakeRatings.Find, as: CakeRatingFind

  # Best Confectioners
  alias SaborBrasileiro.UserRoles.BestConfectioners.Create, as: BestConfectionerCreate
  alias SaborBrasileiro.UserRoles.BestConfectioners.Find, as: BestConfectionerFind

  # FAQ Articles Categories
  alias SaborBrasileiro.FAQ.ArticlesCategories.Create, as: FAQArticleCategoryCreate
  alias SaborBrasileiro.FAQ.ArticlesCategories.Find, as: FAQArticleCategoryFind
  alias SaborBrasileiro.FAQ.ArticlesCategories.Delete, as: FAQArticleCategoryDelete
  alias SaborBrasileiro.FAQ.ArticlesCategories.Show, as: FAQArticleCategoryShow

  # FAQ Articles
  alias SaborBrasileiro.FAQ.Articles.Create, as: FAQArticleCreate
  alias SaborBrasileiro.FAQ.Articles.Find, as: FAQArticleFind
  alias SaborBrasileiro.FAQ.Articles.Show, as: FAQArticleShow

  # FAQ Solicitations
  alias SaborBrasileiro.FAQ.Solicitations.Create, as: FAQSolicitationCreate

  # Cakes Categories
  defdelegate create_cake_category(params), to: CategoryCreate, as: :call
  defdelegate update_category(id, params), to: CategoryUpdate, as: :call
  defdelegate get_categories(query), to: CategoryFind, as: :call
  defdelegate delete_categories(ids), to: CategoryDelete, as: :call

  # Cakes
  defdelegate create_cake(params), to: CakeCreate, as: :call
  defdelegate get_cakes(query), to: CakeFind, as: :call
  defdelegate show_cake(slug), to: CakeShow, as: :call
  defdelegate update_cake(slug, params), to: CakeUpdate, as: :call
  defdelegate delete_cake(id), to: CakeDelete, as: :call

  # Cake Photos
  defdelegate update_cake_photo(id, params), to: CakePhotoUpdate, as: :call

  # Cake Ratings
  defdelegate create_cake_rating(params, assigns), to: CakeRatingCreate, as: :call
  defdelegate find_cake_ratings(query), to: CakeRatingFind, as: :call

  # Users
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate auth_user_credentials(params), to: UserAuthCredentials, as: :call
  defdelegate validate_user_otp(params), to: UserAuthOTP, as: :call
  defdelegate show_user(assigns), to: UserShow, as: :call
  defdelegate check_user_nickname_available(nickname), to: UserCheckNickname, as: :call

  # Best Confectioners
  defdelegate create_best_confectioner(id), to: BestConfectionerCreate, as: :call
  defdelegate find_best_confectioners(query), to: BestConfectionerFind, as: :call

  # FAQ Articles Categories
  defdelegate create_article_category(params), to: FAQArticleCategoryCreate, as: :call
  defdelegate find_article_category(query_params), to: FAQArticleCategoryFind, as: :call
  defdelegate delete_article_categories(ids), to: FAQArticleCategoryDelete, as: :call
  defdelegate show_article_category(slug), to: FAQArticleCategoryShow, as: :call

  # FAQ Articles
  defdelegate create_article(params), to: FAQArticleCreate, as: :call
  defdelegate find_article(query_params), to: FAQArticleFind, as: :call
  defdelegate show_article(slug), to: FAQArticleShow, as: :call

  defdelegate create_solicitation(params), to: FAQSolicitationCreate, as: :call
end
