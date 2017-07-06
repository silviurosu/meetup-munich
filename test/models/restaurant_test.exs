defmodule Meetup.RestaurantTest do
  use Meetup.ModelCase

  alias Meetup.Restaurant

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Restaurant.changeset(%Restaurant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Restaurant.changeset(%Restaurant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
