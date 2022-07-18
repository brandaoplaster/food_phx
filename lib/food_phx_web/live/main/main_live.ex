defmodule FoodPhxWeb.MainLive do
  use FoodPhxWeb, :live_view

  alias FoodPhxWeb.Main.Hero

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
