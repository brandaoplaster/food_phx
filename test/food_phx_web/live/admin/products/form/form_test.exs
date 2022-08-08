defmodule FoodPhxWeb.Admin.Products.FormTest do
  use FoodPhxWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodPhx.Factory

  test "load modal to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new", product: %{name: ""})
           |> render_change() =~ "can&#39;t be blank"
  end

  test "when click to open and then close", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert view |> has_element?("#modal")

    assert view
    |> has_element?("#close", "x")
  end

  test "given a product when submit the form return a message success", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    payload = %{name: "coxinha", description: "test", price: 10, size: "small"}

    {:ok, _, html} =
      view
      |> form("#new", product: payload)
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has created"
  end

  test "given a product that has already exist when try to update without information return an error",
       %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view
           |> element("[data-role=edit-product][data-id=#{product.id}]")
           |> render_click()

    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    assert view
           |> form("##{product.id}", product: %{name: nil})
           |> render_submit() =~ "can&#39;t be blank"
  end

  test "given a product that has already exist when click to edit the open modal", %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view
           |> element("[data-role=edit-product][data-id=#{product.id}]")
           |> render_click()

    assert view
           |> has_element?("#modal")

    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    assert view
           |> form("##{product.id}", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"

    {:ok, view, html} =
      view
      |> form("##{product.id}", product: %{name: "hot dog"})
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product updated"

    assert view
           |> has_element?("[data-role=product-name][data-id=#{product.id}]", "hot dog")
  end

  defp open_modal(view) do
    view
    |> element("[data-role=add-new-product]", "New")
    |> render_click()
  end
end
