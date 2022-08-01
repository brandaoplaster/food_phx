defmodule FoodPhxWeb.Admin.Products.Form do
  use FoodPhxWeb, :live_component

  alias FoodPhx.Products
  alias FoodPhx.Products.Product

  def update(%{product: product} = assigns, socket) do
    changeset = Products.changeset_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> assign(product: product)}
  end

  def handle_event("validate", %{"product" => params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.changeset_product(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => params}, socket) do
    action = socket.assigns.action
    save(socket, action, params)
  end

  def save(socket, :new, params) do
    case Products.create_product(params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product has created")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save(socket, :edit, params) do
    case Products.update_product(socket.assigns.product, params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
