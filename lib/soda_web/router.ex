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

  scope "/api", SodaWeb do
    pipe_through :api

    scope "/v1", as: :api_v1, alias: V1 do
      resources "/photos", PhotoController, except: [:new, :edit]
    end
  end
end
