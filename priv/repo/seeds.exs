alias FoodPhx.Accounts
alias FoodPhx.Products

Accounts.register_user(%{
  email: "admin@gmail.com",
  password: "qazwsxedcrfv",
  role: "ADMIN"
})

Accounts.register_user(%{
  email: "user@gmail.com",
  password: "qazwsxedcrfv",
  role: "USER"
})

Enum.each(1..200, fn _ ->
  image = :rand.uniform(4)

  %{
    name: Faker.Food.dish(),
    description: Faker.Food.description(),
    price: :random.uniform(10_000),
    size: "small",
    product_url: %Plug.Upload{
      content_type: "image/jpg",
      filename: "#{image}.jpg",
      path: "priv/static/images/product_#{image}.jpg"
    }
  }
  |> Products.create_product()
end)
