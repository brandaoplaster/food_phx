defmodule FoodPhxWeb.PageController do
  use FoodPhxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
