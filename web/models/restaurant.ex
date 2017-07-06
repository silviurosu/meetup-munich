defmodule Meetup.Restaurant do
  use Meetup.Web, :model

  schema "restaurants" do
    field :name, :string

    has_many :menus, Meetup.Menu

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
