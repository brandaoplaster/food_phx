defmodule FoodPhxWeb.Admin.Products.Sort do
  use FoodPhxWeb, :live_component

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_sort_order(assigns)

    {:ok, socket}
  end

  defp assign_sort_order(socket, %{options: %{sort_order: sort_order}}) do
    case sort_order == :desc do
      true ->
        socket
        |> assign(icon: "sort_desc.svg")
        |> assign(sort_order: :asc)

      false ->
        socket
        |> assign(icon: "sort_asc.svg")
        |> assign(sort_order: :desc)
    end
  end
end
