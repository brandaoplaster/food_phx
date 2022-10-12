defmodule LiveSessions.Cart do
  import Phoenix.LiveView

  alias FoodPhx.{Accounts, Carts}

  def on_amount(:default, _, session, socket) do
    socket =
      socket
      |> assign_user(session["user_token"])
      |> create_cart()

    {:cont, socket}
  end

  defp assign_user(socket, nil), do: assign_new(socket, :current_user, nil)

  defp assign_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)
  end

  defp create_cart(socket) do
    current_user = socket.assigns.current_user

    case current_user != nil do
      true ->
        cart_id = current_user
        Carts.create(cart_id)
        assign(socket, cart_id: cart_id)

      false ->
        socket
    end
  end
end
