defmodule FoodPhx.Orders.Date.Order do
  @doc false

  use Ecto.Schema
  import Ecto.Changeset

  alias FoodPhx.Accounts.User
  alias FoodPhx.Orders.Date.Item

  @status_values ~w(NOT_STARTED RECEIVED PREPARING DELIVERING DELIVERD)a
  @fields ~w(status)a
  @required_field ~w(total_price total_quantity address phone_number user_id)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :status, Ecto.Enum, values: @status_values, default: :NOT_STARTED
    field :total_price, Money.Ecto.Amount.Type
    field :total_quantity, :integer
    field :address, :string
    field :phone_number, :string

    belongs_to :user_id, User
    has_many :items, Item

    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, @fields ++ @required_field)
    |> validate_required(@required_field)
    |> validate_number(:total_quantity, greater_than: 0)
    |> cast_assoc(:items, with: &Item.changeset/2)
  end
end
