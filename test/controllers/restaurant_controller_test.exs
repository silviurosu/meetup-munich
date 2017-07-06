defmodule Meetup.RestaurantControllerTest do
  use Meetup.ConnCase

  import Meetup.Factories.Restaurant

  alias Meetup.Restaurant

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    r = insert(:restaurant)
    conn = get conn, restaurant_path(conn, :index)
    assert json_response(conn, 200)["data"] == [%{
      "id" => r.id,
      "name" => r.name,
      "menus" => Enum.map(r.menus, fn(m)->
        %{
          "id" => m.id,
          "name" => m.name,
          "items" => m.items
                     |> Enum.sort(&(&1.name < &2.name))
                     |> Enum.map(fn(i)->
            %{
              "id" => i.id,
              "name" => i.name,
              "price" => i.price
            }
          end)
        }
        end)
    }]
  end

  test "shows chosen resource", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = get conn, restaurant_path(conn, :show, restaurant)
    assert json_response(conn, 200)["data"] == %{"id" => restaurant.id,
      "name" => restaurant.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, restaurant_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, restaurant_path(conn, :create), restaurant: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Restaurant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, restaurant_path(conn, :create), restaurant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = put conn, restaurant_path(conn, :update, restaurant), restaurant: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Restaurant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = put conn, restaurant_path(conn, :update, restaurant), restaurant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    restaurant = Repo.insert! %Restaurant{}
    conn = delete conn, restaurant_path(conn, :delete, restaurant)
    assert response(conn, 204)
    refute Repo.get(Restaurant, restaurant.id)
  end
end
