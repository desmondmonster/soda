defmodule SodaWeb.V1.PhotoView do
  use SodaWeb, :view
  alias SodaWeb.V1.PhotoView

  def render("index.json", %{photos: photos}) do
    %{data: render_many(photos, PhotoView, "photo.json")}
  end

  def render("show.json", %{photo: photo}) do
    %{data: render_one(photo, PhotoView, "photo.json")}
  end

  def render("photo.json", %{photo: photo}) do
    %{id: photo.id,
      title: photo.title,
      description: photo.description}
  end
end
