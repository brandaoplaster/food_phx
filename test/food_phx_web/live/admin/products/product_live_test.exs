defmodule FoodPhxWeb.Admin.ProductLiveTest do
  use FoodPhxWeb.ConnCase

  import Phoenix.LiveViewTest

  test "load page product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    assert has_element?(view, "[data-role=product-section]")
    assert has_element?(view, "[data-role=product-table]")
    assert has_element?(view, "[data-id=head-name]")
    assert has_element?(view, "[data-id=head-price]")
    assert has_element?(view, "[data-id=head-size]")
    assert has_element?(view, "[data-id=head-actions]")
    assert has_element?(view, "[data-role=product-list]")
  end
end
