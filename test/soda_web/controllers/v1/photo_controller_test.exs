defmodule SodaWeb.V1.PhotoControllerTest do
  use SodaWeb.ConnCase

  alias Soda.Admin
  alias Soda.Admin.Photo

  @create_attrs %{
    description: "some description",
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, title: nil}

  def fixture(:photo) do
    {:ok, photo} = Admin.create_photo(@create_attrs)
    photo
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all photos", %{conn: conn} do
      conn = get(conn, Routes.api_v1_photo_path(conn, :index))
      assert json_response(conn, 200)["data"] == []

      {:ok, photo} = Admin.create_photo(@create_attrs)
      conn = get(conn, Routes.api_v1_photo_path(conn, :index))
      obj = List.first(json_response(conn, 200)["data"])

      assert obj["title"] == photo.title
      assert obj["description"] == photo.description
    end
  end

  describe "create photo" do
    test "renders photo when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_v1_photo_path(conn, :create), photo: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_v1_photo_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_v1_photo_path(conn, :create), photo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update photo" do
    setup [:create_photo]

    test "renders photo when data is valid", %{conn: conn, photo: %Photo{id: id} = photo} do
      conn = put(conn, Routes.api_v1_photo_path(conn, :update, photo), photo: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_v1_photo_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, photo: photo} do
      conn = put(conn, Routes.api_v1_photo_path(conn, :update, photo), photo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete photo" do
    setup [:create_photo]

    test "deletes chosen photo", %{conn: conn, photo: photo} do
      conn = delete(conn, Routes.api_v1_photo_path(conn, :delete, photo))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_v1_photo_path(conn, :show, photo))
      end
    end
  end

  defp create_photo(_) do
    photo = fixture(:photo)
    {:ok, photo: photo}
  end
end
