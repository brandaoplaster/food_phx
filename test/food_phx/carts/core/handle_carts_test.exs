defmodule FoodPhx.Carts.Core.HandleCartsTest do
  use FoodPhx.DataCase

  import FoodPhx.Factory

  alias FoodPhx.Carts.Core.HandleCarts

  @start_cart %HandleCarts{
    id: 1,
    items: [],
    total_amount: 0,
    total_price: %Money{amount: 0, currency: :BRL}
  }

  describe "handle carts" do
    test "should create a new cart" do
      assert @start_cart == HandleCarts.create_cart(1)
    end

    test "should add a new item  in the car" do
      product = insert(:product)

      cart = HandleCarts.add_new_cart(@start_cart, product)

      assert 1 == cart.total_amount
      assert [%{item: product, total_amount: 1}] == cart.items
      assert product.price == cart.total_price
    end

    test "should add the same item twice" do
      product = insert(:product)

      cart =
        @start_cart
        |> HandleCarts.add_new_cart(product)
        |> HandleCarts.add_new_cart(product)

      assert 2 == cart.total_amount
      assert [%{item: product, total_amount: 2}] == cart.items
      assert Money.add(product.price, product.price) == cart.total_price
    end

    test "should remove an item" do
      product = insert(:product)
      product_2 = insert(:product)

      cart =
        @start_cart
        |> HandleCarts.add_new_cart(product)
        |> HandleCarts.add_new_cart(product)
        |> HandleCarts.add_new_cart(product_2)

      assert 3 == cart.total_amount
      assert [%{item: product, total_amount: 2}, %{item: product_2, total_amount: 1}] == cart.items

      assert Money.add(product.price, product.price)
             |> Money.add(product_2.price) == cart.total_price

      cart = HandleCarts.remove(cart, product.id)

      assert 1 == cart.total_amount
      assert product_2.price == cart.total_price
      assert [%{item: product_2, total_amount: 1}] == cart.items
    end
  end
end
