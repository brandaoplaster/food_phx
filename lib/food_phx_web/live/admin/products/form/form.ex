defmodule FoodPhxWeb.Admin.Products.Form do
  use FoodPhxWeb, :live_component

  alias FoodPhx.Products

  @upload_configs [accept: ~w/.png .jpeg .jpg/, max_entries: 1, max_file_size: 10_000_000]

  def update(%{product: product} = assigns, socket) do
    changeset = Products.changeset_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> allow_upload(:photo, @upload_configs)
     |> assign(product: product)}
  end

  def handle_event("validate", %{"product" => params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.changeset_product(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => params}, socket) do
    action = socket.assigns.action
    params = build_photo_to_upload(socket, params)
    save(socket, action, params)
  end

  def handle_event("cancel", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :photo, ref)}
  end

  def save(socket, :new, params) do
    case Products.create_product(params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product has created")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def save(socket, :edit, params) do
    case Products.update_product(socket.assigns.product, params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp build_photo_to_upload(socket, params) do
    socket
    |> consume_uploaded_entries(:photo, fn %{path: path}, entry ->
      file_name = get_file_name(entry)
      destination = Path.join("/tmp", file_name)
      File.cp!(path, destination)

      file_upload = %Plug.Upload{
        content_type: entry.client_type,
        filename: entry.client_name,
        path: destination
      }

      {:ok, file_upload}
    end)
    |> add_file_upload(params)
  end

  defp add_file_upload([], params), do: params

  defp add_file_upload([file_upload | _], params) do
    Map.put(params, "product_url", file_upload)
  end

  defp get_file_name(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    "#{entry.uuid}.#{ext}"
  end
end
