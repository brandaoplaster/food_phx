alias FoodPhx.Accounts

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
