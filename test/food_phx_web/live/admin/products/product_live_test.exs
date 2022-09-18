defmodule FoodPhxWeb.Admin.ProductLiveTest do
  use FoodPhxWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodPhx.Factory

  describe "test page list products" do
    setup :register_and_log_in_admin

    test "load page product", %{conn: conn} do
      product = insert(:product)

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      assert has_element?(view, "[data-role=product-section]")
      assert has_element?(view, "[data-role=product-table]")
      assert has_element?(view, "[data-id=head-name]")
      assert has_element?(view, "[data-id=head-price]")
      assert has_element?(view, "[data-id=head-size]")
      assert has_element?(view, "[data-id=head-actions]")
      assert has_element?(view, "[data-role=product-list]")

      assert has_element?(view, "[data-role=product-name]", product.name)
      assert has_element?(view, "[data-role=product-price]", "#{product.price}")
      assert has_element?(view, "[data-role=product-size]", product.size)
      # assert has_element?(view, "[data-role=product-item][data-id=#{product.id}]")
    end

    test "given a product that has already exist when click to delete then remove", %{conn: conn} do
      product = insert(:product)

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert has_element?(view, "[data-role=delete][data-id=#{product.id}]", "Delete")

      assert view
             |> element("[data-role=delete][data-id=#{product.id}]", "Delete")
             |> render_click()

      refute has_element?(view, "[data-role=delete][data-id=#{product.id}]")
    end
  end

  describe "filters and sort" do
    setup :register_and_log_in_admin

    test "click sorting by patches", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      view
      |> element("[data-role=sort][data-id=name]")
      |> render_click()

      assert_patched(view, "/admin/products?sort_by=name&sort_order=asc&name=")

      view
      |> element("[data-role=sort][data-id=name]")
      |> render_click()

      assert_patched(view, "/admin/products?sort_by=name&sort_order=desc&name=")
    end
  end
end
