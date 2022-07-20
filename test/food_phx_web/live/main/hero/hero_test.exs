defmodule FoodPhxWeb.Main.HeroTest do
  use FoodPhxWeb.ConnCase

  import Phoenix.LiveViewTest

  test "load page hero", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))

    assert has_element?(view, "[data-role=hero-info]")
    assert has_element?(view, "[data-id=recomendation]", "Make your order")
    assert has_element?(view, "[data-id=cta]", "We are waiting for you!!!")
    assert has_element?(view, "[data-id=cta-button]", "Order new")
  end
end
