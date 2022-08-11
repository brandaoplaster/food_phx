defmodule FoodPhxWeb.Admin.ProductLive.Show do
  use FoodPhxWeb, :live_view

  alias FoodPhx.Products

  def mount(params, session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    product = Products.get!(id)
    {:noreply, socket |> assign(product: product) |> assign(page_title: "Show")}
  end
end
