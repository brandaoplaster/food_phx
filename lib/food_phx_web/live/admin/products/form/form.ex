defmodule FoodPhxWeb.Admin.Products.Form do
  use FoodPhxWeb, :live_component

  alias FoodPhx.Products
  alias FoodPhx.Products.Product

  def update(assigns, socket) do
    changeset = Products.changeset_product()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> assign(product: %Product{})}
  end

  def handle_event("validate", %{"product" => params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.changeset_product(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
