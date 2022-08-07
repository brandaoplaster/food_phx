defmodule FoodPhx.Products.ProductsTest do
  use FoodPhx.DataCase

  alias FoodPhx.Products
  alias FoodPhx.Products.Product

  test "list_products/0" do
    assert Products.list_products() == []
  end

  test "get!/1" do
    params = %{name: "pão de queijo", size: "big", price: 50, description: "queijo"}

    {:ok, product} = Products.create_product(params)
    assert Products.get!(product.id).name == product.name
  end

  test "create_product" do
    params = %{name: "pão de queijo", size: "big", price: 50, description: "queijo"}

    assert {:ok, %Product{} = product} = Products.create_product(params)
    assert product.name == params.name
  end

  test "update product" do
    params = %{name: "pão de queijo", size: "big", price: 50, description: "queijo"}

    assert {:ok, product} = Products.create_product(params)
    assert {:ok, %Product{} = product} = Products.update_product(product, %{name: "uva"})
    assert product.name == "uva"
  end

  test "delete/1" do
    params = %{name: "pão de queijo", size: "big", price: 50, description: "queijo"}

    {:ok, product} = Products.create_product(params)
    assert {:ok, %Product{}} = Products.delete(product.id)
    assert_raise Ecto.NoResultsError, fn -> Products.get!(product.id) end
  end

  test "give a product with the same name should throw an error message" do
    params = %{name: "pão de queijo", size: "big", price: 50, description: "queijo"}

    assert {:ok, %Product{} = _product} = Products.create_product(params)
    assert {:error, changeset} = Products.create_product(params)
    assert "has already been taken" in errors_on(changeset).name
    assert %{name: ["has already been taken"]} == errors_on(changeset)
  end
end
