defmodule FoodPhxWeb.MainLive do
  use FoodPhxWeb, :live_view

  alias FoodPhxWeb.Main.Hero
  alias FoodPhxWeb.Main.Items

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
