defmodule FriendlyWeb.Router do
  use FriendlyWeb, :router
  require Ueberauth


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  ## AUTH ROUTES
  scope "/auth", FriendlyWeb do
    pipe_through :browser
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  ## ROOT ROUTES
  scope "/", FriendlyWeb do
    pipe_through :browser
    get "/", PageController, :index
    get "/logout", AuthController, :logout
    resources "/tasks", TaskController
    resources "/customers", CustomerController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FriendlyWeb do
  #   pipe_through :api
  # end

end
