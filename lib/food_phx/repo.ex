defmodule FoodPhx.Repo do
  use Ecto.Repo,
    otp_app: :food_phx,
    adapter: Ecto.Adapters.Postgres
end
