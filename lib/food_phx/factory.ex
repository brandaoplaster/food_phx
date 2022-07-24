defmodule FoodPhx.Factory do
  use ExMachina.Ecto, repo: FoodPhx.Repo
  alias FoodPhx.Products.Product

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish(),
      price: 100,
      size: "big"
    }
  end
end
