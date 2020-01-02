defmodule Reedly.Database.Test.CategoryTestHelper do
  @moduledoc "Test helpers functions for category"

  alias Reedly.Database.Category

  @attributes ~w[
    name
    type
  ]a
  @created_category_attributes [:id | @attributes]

  def attributes(categories, attributes) when is_list(categories),
    do: Enum.map(categories, &attributes(&1, attributes))

  def attributes(%Category{} = category), do: attributes(category, @attributes)
  def attributes(%Category{} = category, attributes), do: Map.take(category, attributes)

  def equal?(%Category{} = category_1, %Category{} = category_2),
    do: attributes(category_1, @created_category_attributes) == attributes(category_2, @created_category_attributes)

  def equal?(%Category{} = category, attributes), do: attributes(category) == attributes

  def equal?(categories_1, categories_2) when is_list(categories_1) and is_list(categories_2),
    do: attributes(categories_1, @created_category_attributes) == attributes(categories_2, @created_category_attributes)
end
