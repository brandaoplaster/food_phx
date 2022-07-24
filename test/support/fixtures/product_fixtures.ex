defmodule FoodPhx.ProductFixtures do
  alias FoodPhx.Products

  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: Faker.Food.description(),
        name: Faker.Food.dish(),
        price: 100,
        size: "big"
      })
      |> Products.create_product()

    product
  end
end
