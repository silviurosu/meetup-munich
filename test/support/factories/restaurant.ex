defmodule Meetup.Factories.Restaurant do
  @moduledoc """
  Factories for restaurant
  """

  use ExMachina.Ecto, repo: Meetup.Repo

  alias Meetup.Restaurant
  alias Meetup.Menu
  alias Meetup.Item

  def restaurant_factory do
    %Restaurant {
      name: "Demo Restaurant",
      menus: [
        build(:menu)
      ]
    }
  end

  def menu_factory do
    %Menu {
      name: "Dinner",
      items: [
        build(:pizza),
        build(:pasta)
      ]
    }
  end

  def pizza_factory do
    %Item{
      name: "Pizza",
      price: 100
    }
  end

  def pasta_factory do
    %Item{
      name: "Pasta",
      price: 200
    }
  end
end
