defmodule FoodPhxWeb.Admin.Products.FormTest do
  use FoodPhxWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load modal to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new", product: %{name: ""})
           |> render_change() =~ "can&#39;t be blank"
  end

  defp open_modal(view) do
    view
    |> element("[data-role=add-new-product]", "New")
    |> render_click()
  end
end
