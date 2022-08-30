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
    assert "" == Products.get_image(product)
  end

  test "create_product with image and get the image url" do
    file_upload = %Plug.Upload{
      content_type: "image/png",
      filename: "photo.png",
      path: "test/support/fixtures/photo.png"
    }

    params = %{
      name: "pão de queijo",
      size: "big",
      price: 50,
      description: "queijo",
      product_url: file_upload
    }

    assert {:ok, %Product{} = product} = Products.create_product(params)
    [url | _] = Products.get_image(product)
    assert String.contains?(url, file_upload.filename)
  end

  test "create_product with invalid image type" do
    file_upload = %Plug.Upload{
      content_type: "image/svg",
      filename: "photo.svg",
      path: "test/support/fixtures/photo.svg"
    }

    params = %{
      name: "pão de queijo",
      size: "big",
      price: 50,
      description: "queijo",
      product_url: file_upload
    }

    assert {:error, changeset} = Products.create_product(params)
    assert "File type is invalid" in errors_on(changeset).product_url
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
