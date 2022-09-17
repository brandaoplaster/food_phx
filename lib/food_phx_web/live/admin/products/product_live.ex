defmodule FoodPhxWeb.Admin.ProductLive do
  use FoodPhxWeb, :live_view

  alias FoodPhx.Products
  alias FoodPhx.Products.Product
  alias FoodPhxWeb.Admin.ProductRow
  alias FoodPhxWeb.Admin.Products.FilterByName
  alias FoodPhxWeb.Admin.Products.Form
  alias FoodPhxWeb.Admin.Products.Sort

  def mount(_assign, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    name = params["name"] || ""
    sort_by = (params["sort_by"] || "updated_at") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()
    sort = %{sort_by: sort_by, sort_order: sort_order}

    live_action = socket.assigns.live_action
    products = Products.list_products(name: name, sort: sort)
    assigns = [products: products, name: "", loading: false]

    options = sort

    socket =
      socket
      |> apply_action(live_action, params)
      |> assign(assigns)
      |> assign(options: options)

    {:noreply, apply_action(socket, live_action, params)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    {:ok, _} = Products.delete(id)

    {:noreply, assign(socket, :products, Products.list_products())}
  end

  def handle_event("filter-by-name", %{"name" => name}, socket) do
    socket = apply_filters(socket, name)
    {:noreply, socket}
  end

  def handle_info({:list_products, name}, socket) do
    {:noreply, perform_filter(socket, name)}
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

  defp apply_filters(socket, name) do
    assigns = [products: [], name: name, loading: true]
    send(self(), {:list_products, name})
    assign(socket, assigns)
  end

  defp perform_filter(socket, name) do
    name
    |> Products.list_products()
    |> return_filter_response(socket, name)
  end

  defp return_filter_response([], socket, name) do
    assigns = [products: [], loading: false]

    socket
    |> put_flash(:info, "There is no product with \"#{name}\"")
    |> assign(assigns)
  end

  defp return_filter_response(products, socket, _name) do
    assigns = [products: products, loading: false]

    assign(socket, assigns)
  end
end
