defmodule FoodPhxWeb.Admin.Products.FilterByNameTest do
  use FoodPhxWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodPhx.Factory

  describe "test filter" do
    setup :register_and_log_in_admin

    test "filter by name", %{conn: conn} do
      product_a = insert(:product)
      product_b = insert(:product)

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert has_element?(view, "[data-role=product-item] [data-id=#{product_a.id}]")
      assert has_element?(view, "[data-role=product-item] [data-id=#{product_b.id}]")

      view
      |> form("#filter-by-name", %{name: product_a.name})
      |> render_submit()

      assert has_element?(view, "[data-role=product-item] [data-id=#{product_a.id}]")
      refute has_element?(view, "[data-role=product-item] [data-id=#{product_b.id}]")
    end

    test "filter by name with no value", %{conn: conn} do
      product_a = insert(:product)
      product_b = insert(:product)

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert has_element?(view, "[data-role=product-item] [data-id=#{product_a.id}]")
      assert has_element?(view, "[data-role=product-item] [data-id=#{product_b.id}]")

      view
      |> form("#filter-by-name", %{name: "xxxxx"})
      |> render_submit()

      refute has_element?(view, "[data-role=product-item] [data-id=#{product_a.id}]")
      refute has_element?(view, "[data-role=product-item] [data-id=#{product_b.id}]")
    end
  end
end
