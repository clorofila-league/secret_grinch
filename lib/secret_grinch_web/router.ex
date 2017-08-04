defmodule SecretGrinchWeb.Router do
  use SecretGrinchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SecretGrinchWeb.Auth, repo: SecretGrinch.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SecretGrinchWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    resources "/matches", MatchController do
      resources "/messages", MessageController, only: [:new, :create]
      resources "/users", MatchUsersController, only: [:create]
    end

  end

  # Other scopes may use custom stacks.
  # scope "/api", SecretGrinchWeb do
  #   pipe_through :api
  # end
end
