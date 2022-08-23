defmodule LiveSessions.PermissionsTest do
  use FoodPhxWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodPhx.Factory

  describe "success when is admin" do
    setup :register_and_log_in_admin

    test "when admin is corrent", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _} = live(conn, Routes.admin_product_path(conn, :index))
      assert has_element?(view, "[data-role=product-action][data-id=#{product.id}]")
    end
  end

  describe "when is not admin" do
    setup :register_and_log_in_user

    test "when admin is wrong", %{conn: conn} do
      {:error, {:redirect, %{flash: %{"error" => message}, to: "/"}}} =
        live(conn, Routes.admin_product_path(conn, :index))

      assert message == "You don`t have permissions to access this page"
    end
  end

  describe "when user is not logged in" do
    test "without loggin", %{conn: conn} do
      {:error, {:redirect, %{flash: %{"error" => message}, to: "/users/log_in"}}} =
        live(conn, Routes.admin_product_path(conn, :index))

      assert message == "You must log in to access this page."
    end
  end
end
