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

  def remove(cart, item_id) do
    {items, item_removed} = Enum.reduce(cart.items, {[], nil}, &remove_item(&1, &2, item_id))
    total_price_item_removed = Money.multiply(item_removed.item.price, item_removed.total_amount)
    total_price = Money.subtract(cart.total_price, total_price_item_removed)

    %{
      cart
      | items: items,
        total_amount: cart.total_amount - item_removed.total_amount,
        total_price: total_price
    }
  end

  def increment(%{items: items} = cart, item_id) do
    {item_update, product} =
      Enum.reduce(items, {[], nil}, fn item, acc ->
        if item.item.id == item_id do
          {list, _product} = acc
          update_item = %{item | total_amount: item.total_amount + 1}
          item_update = [update_item]
          {list ++ item_update, update_item}
        else
          {list, item_update} = acc
          {[item] ++ list, item_update}
        end
      end)

    total_price = Money.add(cart.total_price, product.item.price)
    %{cart | items: item_update, total_amount: cart.total_amount + 1, total_price: total_price}
  end

  defp remove_item(element, accumulator, item_id) do
    case element.item.id == item_id do
      true ->
        {list, _acc} = accumulator
        {list, element}

      false ->
        {list, acc} = accumulator
        {[element] ++ list, acc}
    end
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
