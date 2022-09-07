defmodule FoodPhxWeb.Main.ItemTest do
  use FoodPhxWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodPhx.Factory

  test "load page item", %{conn: conn} do
    product = insert(:product)
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))

    assert has_element?(view, "#item-#{product.id}")
    assert has_element?(view, "[data-role=product-img]")
  end
end
