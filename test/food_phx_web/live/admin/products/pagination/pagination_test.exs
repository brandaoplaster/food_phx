defmodule FoodPhxWeb.Admin.Product.PaginationTest do
  use FoodPhxWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodPhx.Factory

  describe "pagination" do
    setup :register_and_log_in_admin

    test "clicking next, preview and page", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      view
      |> element("[data-role=paginate][data-id=next]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=2&per_page=4&sort_by=updated_at&name=&sort_order=desc"
      )

      view
      |> element("[data-role=paginate][data-id=prev]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=1&per_page=4&sort_by=updated_at&name=&sort_order=desc"
      )

      view
      |> element("[data-role=paginate][data-id=2]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=2&per_page=4&sort_by=updated_at&name=&sort_order=desc"
      )

      view
      |> element("[data-role=paginate][data-id=3]")
      |> render_click()

      assert_patched(
        view,
        "/admin/products?page=3&per_page=4&sort_by=updated_at&name=&sort_order=desc"
      )
    end

    test "test using url params", %{conn: conn} do
      [product_1, product_2] = for _ <- 1..2, do: insert(:product)

      {:ok, view, _html} =
        live(conn, Routes.admin_product_path(conn, :index, page: 1, per_page: 1))

      assert has_element?(view, "[data-role=product-name]", product_1.name)
      refute has_element?(view, "[data-role=product-name]", product_2.name)

      {:ok, view, _html} =
        live(conn, Routes.admin_product_path(conn, :index, page: 2, per_page: 1))

      refute has_element?(view, "[data-role=product-name]", product_1.name)
      assert has_element?(view, "[data-role=product-name]", product_2.name)
    end
  end
end
