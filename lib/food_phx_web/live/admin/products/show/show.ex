defmodule FoodPhxWeb.Admin.ProductLive.Show do
  use FoodPhxWeb, :live_view

  def mount(params, session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, socket) do
    {:noreply, socket}
  end
end
