defmodule FoodPhxWeb.Main.Items do
  use FoodPhxWeb, :live_component

  alias FoodPhx.Products
  alias FoodPhxWeb.Main.Items.Item

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(page: 1, per_page: 8)
      |> assigns_products()

    {:ok, socket}
  end

  def handle_event("load-more", _, socket) do
    socket =
      socket
      |> update(:page, &(&1 + 1))
      |> assigns_products()

    {:noreply, socket}
  end

  defp assigns_products(socket) do
    page = socket.assigns.page
    per_page = socket.assigns.per_page
    paginate = [{:paginate, %{page: page, per_page: per_page}}]
    products = Products.list_products(paginate)
    assign(socket, products: products)
  end
end
