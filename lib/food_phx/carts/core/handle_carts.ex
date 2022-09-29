defmodule FoodPhx.Carts.Core.HandleCarts do
  defstruct id: nil, items: [], total_amount: 0, total_price: Money.new(0)

  def create_cart(id), do: %__MODULE__{id: id}

  def add_new_cart(cart, item) do
    total_price = Money.add(cart.total_price, item.price)

    %{
      cart
      | total_amount: cart.total_amount + 1,
        items: new_item(cart.items, item),
        total_price: total_price
    }
  end

  defp new_item(items, item) do
    is_there_item_id? = Enum.find(items, &(&1.item.id == item.id))

    case is_nil(is_there_item_id?) do
      true ->
        items ++ [%{item: item, total_amount: 1}]

      _ ->
        items
        |> Map.new(fn item -> {item.item.id, item} end)
        |> Map.update!(item.id, &%{&1 | total_amount: &1.total_amount + 1})
        |> Map.values()
    end
  end
end
