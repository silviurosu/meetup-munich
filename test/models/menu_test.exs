defmodule Meetup.MenuTest do
  use Meetup.ModelCase

  alias Meetup.Menu

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Menu.changeset(%Menu{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Menu.changeset(%Menu{}, @invalid_attrs)
    refute changeset.valid?
  end
end
