defmodule Meetup.Menu do
  use Meetup.Web, :model

  schema "menus" do
    field :name, :string
    belongs_to :restaurant, Meetup.Restaurant
    has_many :items, Meetup.Item
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
