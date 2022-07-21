defmodule FoodPhxWeb.Main.ItemsTest do
  use FoodPhxWeb.ConnCase

  import Phoenix.LiveViewTest

  test "load page items", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))

    assert has_element?(view, "[data-role=items-info][data-id=all-food]", "All Foods")
  end
end
