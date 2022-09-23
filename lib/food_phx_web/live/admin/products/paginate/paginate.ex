defmodule FoodPhxWeb.Admin.Products.Paginate do
  use FoodPhxWeb, :live_component

  def page_link(assigns) do
    %{
      name: name,
      options: options,
      page: page,
      socket: socket,
      text: text,
      data_id: data_id
    } = assigns

    ~H"""
      <%= live_patch(text, to: Routes.admin_product_path(socket, :index,
        page: page,
        per_page: options.per_page,
        sort_by: options.sort_by,
        name: name,
        sort_order: options.sort_order
      ), "data-role": "paginate", "data-id": data_id) %>
    """
  end

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
