defmodule FoodPhx.Products do
  alias FoodPhx.Products.Product
  alias FoodPhx.Repo

  def list_products do
    Repo.all(Product)
  end

  def create_product(attrs \\ %{}) do
    attrs
    |> Product.changeset()
    |> Repo.insert()
  end
end
