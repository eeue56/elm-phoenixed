defmodule ElmPhoenixed.Router do
  use ElmPhoenixed.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
  #  plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElmPhoenixed do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/api", PageController, :api
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElmPhoenixed do
  #   pipe_through :api
  # end
end
