defmodule FoodPhxWeb.Admin.Orders.Layer do
  use FoodPhxWeb, :live_component

  alias __MODULE__.Card

  def update(assigns, socket) do
    cards = [%{id: "1233"}]
    {:ok, socket |> assign(assigns) |> assign(cards: cards)}
  end
end
