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

%{
  name: Faker.Food.dish(),
  description: Faker.Food.description(),
  price: :random.uniform(10_000),
  size: "small",
  product_url: %Plug.Upload{
    content_type: "image/png",
    filename: "logo.png",
    path: "priv/static/images/logo.png"
  }
}
|> Products.create_product()
