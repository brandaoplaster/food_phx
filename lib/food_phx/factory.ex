defmodule FoodPhx.Factory do
  use ExMachina.Ecto, repo: FoodPhx.Repo
  alias FoodPhx.Products.Product

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish() <> (:rand.uniform(10_000) |> Integer.to_string()),
      price: :rand.uniform(10_000),
      size: "big"
    }
  end
end
