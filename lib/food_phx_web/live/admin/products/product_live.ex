defmodule FoodPhxWeb.Admin.ProductLive do
  use FoodPhxWeb, :live_view

  alias FoodPhx.Products
  alias FoodPhx.Products.Product
  alias FoodPhxWeb.Admin.Products.Form

  def mount(_assign, _session, socket) do
    products = Products.list_products()
    {:ok, socket |> assign(products: products)}
  end

  def render_params(params, _url, socket) do
    live_action = socket.assigns.live_action
    {:noreply, apply_action(socket, live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Create new product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = Products.get!(id)
    socket
    |> assign(:page_title, "Edit product")
    |> assign(:product, product)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "List product")
    |> assign(:product, nil)
  end
end
