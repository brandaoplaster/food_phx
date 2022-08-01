defmodule FoodPhx.Products do
  alias FoodPhx.Products.Product
  alias FoodPhx.Repo

  def list_products do
    Repo.all(Product)
  end

  def get!(id) do
    Repo.get!(Product, id)
  end

  def create_product(attrs \\ %{}) do
    attrs
    |> Product.changeset()
    |> Repo.insert()
  end

  def update_product(product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def changeset_product(product, params \\ %{}), do: Product.changeset(product, params)
end
