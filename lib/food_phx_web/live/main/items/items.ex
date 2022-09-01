defmodule FoodPhxWeb.Main.Items do
  use FoodPhxWeb, :live_component

  alias FoodPhxWeb.Main.Items.Item
  alias FoodPhx.Products

  def update(assigns, socket) do
    products = Products.list_products()

    socket =
      socket
      |> assign(assigns)
      |> assign(products: products)

    {:ok, socket}
  end
end
