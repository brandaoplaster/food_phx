defmodule FoodPhxWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  def modal(assigns) do
    ~H"""
    <div class="phx-modal fade-in">
      <div class="phx-modal-content fade-in-scale">
        <form>
            <input type="text" placeholder="name">
            <input type="text" placeholder="price">
            <input type="text" placeholder="size">
            <input type="text" placeholder="description">
            <button type="button">Create Product</button>
        </form>
      </div>
    </div>
    """
  end
end
