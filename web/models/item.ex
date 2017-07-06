defmodule Meetup.Item do
  use Meetup.Web, :model

  schema "items" do
    field :name, :string
    field :price, :integer
    belongs_to :menu, Meetup.Menu

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :price])
    |> validate_required([:name, :price])
  end
end
