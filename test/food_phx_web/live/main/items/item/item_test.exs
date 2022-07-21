defmodule FoodPhxWeb.Main.ItemTest do
  use FoodPhxWeb.ConnCase

  import Phoenix.LiveViewTest

  test "load page item", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))

    assert has_element?(view, "[data-role=img]")
  end
end
