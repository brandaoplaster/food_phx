defmodule FoodPhx.Carts do
  def create(cart_id),
    do: GenServer.cast(:cart_session, {:create, cart_id})

  def remove(cart_id),
    do: GenServer.cast(:cart_session, {:remove, cart_id})

  def get(cart_id),
    do: GenServer.call(:cart_session, {:get, cart_id})

  def add(cart_id, product),
    do: GenServer.cast(:cart_session, {:add, cart_id, product})

  def increment(cart_id, product_id),
    do: GenServer.call(:cart_session, {:increment, cart_id, product_id})

  def decrement(cart_id, product_id),
    do: GenServer.call(:cart_session, {:decrement, cart_id, product_id})
end
