defmodule Soda.Admin.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :description, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:title, :description, :url])
    |> validate_required([:title, :description])
  end
end
