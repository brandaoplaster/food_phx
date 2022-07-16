defmodule FoodPhxWeb.MainLive do
  use FoodPhxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
