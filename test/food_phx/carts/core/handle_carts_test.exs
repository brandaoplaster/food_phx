defmodule FoodPhx.Carts.Core.HandleCartsTest do
  use FoodPhx.DataCase

  alias FoodPhx.Carts.Core.HandleCarts

  describe "handle carts" do
    test "should create a new cart" do
      assert %HandleCarts{
               id: 1,
               items: [],
               total_amount: 0,
               total_items: 0,
               total_price: %Money{amount: 0, currency: :BRL}
             } == HandleCarts.create_cart(1)
    end
  end
end
