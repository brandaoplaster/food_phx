defmodule FoodPhxWeb.Admin.Orders.SideMenuTest do
  use FoodPhxWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is side menu is loaded" do
    setup :register_and_log_in_admin

    test "render main element", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=side-title]", "Orders")

      assert has_element?(view, "[data-role=all-orders]", "All")
      assert has_element?(view, "[data-role=all-orders-amount]", "30")

      assert has_element?(view, "[data-role=all-not-started]", "Not Started")
      assert has_element?(view, "[data-role=all-not-started-amount]", "3")

      assert has_element?(view, "[data-role=received]", "Received")
      assert has_element?(view, "[data-role=received-amount]", "3")

      assert has_element?(view, "[data-role=preparing]", "Preparing")
      assert has_element?(view, "[data-role=preparing-amount]", "3")

      assert has_element?(view, "[data-role=delivering]", "Delivering")
      assert has_element?(view, "[data-role=delivering-amount]", "3")

      assert has_element?(view, "[data-role=delivered]", "delivered")
      assert has_element?(view, "[data-role=delivered-amount]", "3")
    end
  end
end
