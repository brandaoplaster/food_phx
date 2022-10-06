defmodule FoodPhx.Carts.CartsTest do
  use FoodPhx.DataCase

  import FoodPhx.Factory

  alias FoodPhx.Carts

  test "should create session" do
    assert :ok == Carts.create(1)
  end

  test "should create session twice" do
    assert :ok == Carts.create(1)
    assert :ok == Carts.create(1)
  end

  test "should create a new product" do
    cart_id = Ecto.UUID.generate()
    assert :ok == Carts.create(cart_id)
    product = insert(:product)
    assert :ok == Carts.add(cart_id, product)
    assert 1 == Carts.get(cart_id).total_amount
  end

  test "should add the same item" do
    cart_id = Ecto.UUID.generate()
    assert :ok == Carts.create(cart_id)
    product = insert(:product)
    assert :ok == Carts.add(cart_id, product)
    assert 2 == Carts.increment(cart_id, product.id).total_amount
  end

  test "should decrement the same item" do
    cart_id = Ecto.UUID.generate()
    assert :ok == Carts.create(cart_id)
    product = insert(:product)
    assert :ok == Carts.add(cart_id, product)
    assert 0 == Carts.decrement(cart_id, product.id).total_amount
  end

  test "should remove product" do
    cart_id = Ecto.UUID.generate()
    assert :ok == Carts.create(cart_id)
    product = insert(:product)
    assert :ok == Carts.add(cart_id, product)
    assert :ok == Carts.add(cart_id, product)
    assert 2 == Carts.get(cart_id).total_amount
    assert 0 == Carts.remove(cart_id, product.id).total_amount
  end
end
