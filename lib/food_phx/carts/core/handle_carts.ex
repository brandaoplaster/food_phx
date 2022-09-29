defmodule FoodPhx.Carts.Core.HandleCarts do
  defstruct id: nil, items: [], total_items: 0, total_amount: 0, total_price: Money.new(0)

  def create_cart(id), do: %__MODULE__{id: id}

  def add_new_cart(cart, item) do
    total_price = Money.add(cart.total_price, item.price)
    total_items = cart.items + 1

    %{
      cart
      | total_amount: cart.total_amount + 1,
        items: cart.items ++ [item],
        total_price: total_price,
        total_items: total_items
    }
  end
end
