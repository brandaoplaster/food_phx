defmodule FoodPhx.Carts.Core.HandleCarts do
  defstruct id: nil, items: [], total_items: 0, total_amount: 0, total_price: Money.new(0)

  def create_cart(id), do: %__MODULE__{id: id}
end
