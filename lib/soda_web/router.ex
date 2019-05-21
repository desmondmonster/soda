defmodule SodaWeb.Router do
  use SodaWeb, :router

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

  scope "/", SodaWeb do
    pipe_through :browser
  end

  # Other scopes may use custom stacks.
  # scope "/api", SodaWeb do
  #   pipe_through :api
  # end
end
