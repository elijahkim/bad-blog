defmodule MyBadBlogWeb.Router do
  use MyBadBlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug MyBadBlogWeb.Plugs.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyBadBlogWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sessions", SessionController
    resources "/posts", PostController, only: [:show] do
      resources "/comments", CommentController, only: [:new]
    end
    resources "/comments", CommentController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyBadBlogWeb do
  #   pipe_through :api
  # end
end
