defmodule FoodPhxWeb.Admin.OrdersLiveTest do
  use FoodPhxWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is order is loaded" do
    setup :register_and_log_in_admin

    test "render main element", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#side-menu")

      assert has_element?(view, "[data-role=layers]")
    end
  end
end
