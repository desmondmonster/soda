defmodule SodaWeb.PageController do
  use SodaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
