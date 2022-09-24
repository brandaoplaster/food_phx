defmodule FoodPhxWeb.Admin.Products.SelectPerPage do
  use FoodPhxWeb, :live_component

  def handle_event("update-select-perpage", %{"per-page-select" => per_page}, socket) do
    to =
      Routes.admin_product_path(socket, :index,
        page: socket.assigns.option.page,
        per_page: per_page,
        sort_by: socket.assigns.option.sort_by,
        sort_order: socket.assigns.option.sort_order,
        name: socket.assigns.name
      )

    {:noreply, push_patch(socket, to: to)}
  end
end
