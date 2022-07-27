defmodule FoodPhxWeb.Admin.Products.FormTest do
  use FoodPhxWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load modal to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new_product", product: %{name: ""})
           |> render_change() =~ "can&#39;t be blank"
  end
end
