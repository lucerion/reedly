defmodule Reedly.Database.Test.CategoryTestHelper do
  @moduledoc "Test helpers functions for category"

  alias Reedly.Database.Category

  @attributes ~w[
    name
    type
  ]a
  @attributes_with_id [:id | @attributes]

  defp attributes(%Category{} = category), do: attributes(category, @attributes)
  defp attributes(%Category{} = category, attributes), do: Map.take(category, attributes)

  def equal?(%Category{} = category_1, %Category{} = category_2),
    do: attributes(category_1, @attributes_with_id) == attributes(category_2, @attributes_with_id)

  def equal?(%Category{} = category, attributes), do: attributes(category) == attributes
end
