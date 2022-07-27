defmodule FoodPhxWeb.Admin.ProductLive do
  use FoodPhxWeb, :live_view

  alias FoodPhx.Products
  alias FoodPhxWeb.Admin.Products.Form

  def mount(_assign, _session, socket) do
    products = Products.list_products()
    {:ok, socket |> assign(products: products)}
  end
end
