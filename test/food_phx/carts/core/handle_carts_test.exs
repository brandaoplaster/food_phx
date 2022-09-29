defmodule FoodPhx.Carts.Core.HandleCartsTest do
  use FoodPhx.DataCase

  import FoodPhx.Factory

  alias FoodPhx.Carts.Core.HandleCarts

  @start_cart %HandleCarts{
    id: 1,
    items: [],
    total_amount: 0,
    total_items: 0,
    total_price: %Money{amount: 0, currency: :BRL}
  }

  describe "handle carts" do
    test "should create a new cart" do
      assert @start_cart == HandleCarts.create_cart(1)
    end

    test "should add a new item  in the car" do
      product = insert(:produc)

      cart = HandleCarts.add_new_cart(@start_cart, product)

      assert 1 == cart.total_amount
      assert 1 == cart.total_items
      assert [product] == cart.items
      assert product.price == cart.total_price
    end
  end
end
