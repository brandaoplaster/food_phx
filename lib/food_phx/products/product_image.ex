defmodule FoodPhx.Products.ProductImage do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  @extension_whitelist ~w(.png .jpeg .jpg)

  def validate({file, _}) do
    file_extension =
      file.file_name()
      |> Path.extname()
      |> String.downcase()

    case Enum.member?(@extension_whitelist, file_extension) do
      true -> true
      false -> {:error, "File type is invalid"}
    end
  end

  def storage_dir(_, {_file, product}) do
    "/priv/static/uploads/products/#{product.name}"
  end
end
