defmodule FoodPhxWeb.Admin.OrderLive do
  use FoodPhxWeb, :live_view

  alias __MODULE__.Layer
  alias __MODULE__.SideMenu

  def mount(_, _, socket) do
    {:ok, socket}
  end
end
