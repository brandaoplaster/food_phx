defmodule FoodPhxWeb.Admin.Products.Form do
  use FoodPhxWeb, :live_component

  alias FoodPhx.Products

  def update(assigns, socket) do
    changeset = Products.changeset_product()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)}
  end
end
