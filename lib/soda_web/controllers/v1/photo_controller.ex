defmodule SodaWeb.V1.PhotoController do
  use SodaWeb, :controller

  alias Soda.Admin
  alias Soda.Admin.Photo

  action_fallback SodaWeb.FallbackController

  def index(conn, _params) do
    photos = Admin.list_photos()
    render(conn, "index.json", photos: photos)
  end

  def create(conn, %{"photo" => photo_params}) do
    with {:ok, %Photo{} = photo} <- Admin.create_photo(photo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_v1_photo_path(conn, :show, photo))
      |> render("show.json", photo: photo)
    end
  end

  def show(conn, %{"id" => id}) do
    photo = Admin.get_photo!(id)
    render(conn, "show.json", photo: photo)
  end

  def update(conn, %{"id" => id, "photo" => photo_params}) do
    photo = Admin.get_photo!(id)

    with {:ok, %Photo{} = photo} <- Admin.update_photo(photo, photo_params) do
      render(conn, "show.json", photo: photo)
    end
  end

  def delete(conn, %{"id" => id}) do
    photo = Admin.get_photo!(id)

    with {:ok, %Photo{}} <- Admin.delete_photo(photo) do
      send_resp(conn, :no_content, "")
    end
  end
end
