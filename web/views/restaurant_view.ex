defmodule Meetup.RestaurantView do
  use Meetup.Web, :view

  alias Meetup.RestaurantView

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, RestaurantView, "restaurant-complete.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{data: render_one(restaurant, RestaurantView, "restaurant.json")}
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{id: restaurant.id,
      name: restaurant.name}
  end

  def render("restaurant-complete.json", %{restaurant: restaurant}) do
    %{id: restaurant.id,
      name: restaurant.name,
      menus: render_many(restaurant.menus, RestaurantView, "menu-complete.json", as: :menu)
    }
  end

  def render("menu-complete.json", %{menu: menu}) do
    %{id: menu.id,
      name: menu.name,
      items: render_many(menu.items, RestaurantView, "item.json", as: :item)
    }
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      name: item.name,
      price: item.price
    }
  end
end
