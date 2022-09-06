defmodule FoodPhx.Products do
  import Ecto.Query

  alias FoodPhx.Products.Product
  alias FoodPhx.Products.ProductImage
  alias FoodPhx.Repo

  def list_products(name) do
    name = "%#{name}%"

    Product
    |> where([p], ilike(p.name, ^name))
    |> Repo.all()
  end

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

  def delete(id) do
    id
    |> get!()
    |> Repo.delete()
  end

  def changeset_product(product, params \\ %{}), do: Product.changeset(product, params)

  def get_image(product) do
    {product.product_url, product}
    |> ProductImage.url()
    |> get_image_url()
  end

  defp get_image_url(nil), do: ""

  defp get_image_url(url) do
    [_, url] = String.split(url, "/priv/static")
    url
  end
end
