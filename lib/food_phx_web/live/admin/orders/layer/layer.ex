defmodule FoodPhxWeb.Admin.Orders.Layer do
  use FoodPhxWeb, :live_component

  alias __MODULE__.Card

  def update(assigns, socket) do
    cards = [
      %{id: "1233"},
      updatea_at: DateTime.utc_now(),
      status: :NOT_STARTED,
      user: %{email: "l@gmail.com"},
      total_price: Money.new(300),
      total_amount: 2,
      items: [%{id: "321", amount: 10, product: %{name: "queijo", price: Money.new(200)}}]
    ]

    {:ok, socket |> assign(assigns) |> assign(cards: cards)}
  end
end
