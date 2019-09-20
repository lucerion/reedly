defmodule Reedly.Database.Test.CategoryTestHelper do
  @moduledoc "Test helpers functions for category"

  alias Reedly.Database.Category

  @attributes ~w[
    name
    type
  ]a
  @attributes_with_id [:id | @attributes]

  def attributes(categories, attributes) when is_list(categories),
    do: Enum.map(categories, &attributes(&1, attributes))

  def attributes(%Category{} = category), do: attributes(category, @attributes)
  def attributes(%Category{} = category, attributes), do: Map.take(category, attributes)

  def equal?(%Category{} = category_1, %Category{} = category_2),
    do: attributes(category_1, @attributes_with_id) == attributes(category_2, @attributes_with_id)

  def equal?(%Category{} = category, attributes), do: attributes(category) == attributes

  def equal?(categories_1, categories_2) when is_list(categories_1) and is_list(categories_2),
    do: attributes(categories_1, @attributes_with_id) == attributes(categories_2, @attributes_with_id)
end
