defmodule FoodPhx.Products.Products do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields ~w(description)a
  @required_fields ~w(name price size)a

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :integer
    field :size, :string

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, %{} = attrs) do
    struct
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
