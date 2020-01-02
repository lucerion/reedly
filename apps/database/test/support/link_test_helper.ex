defmodule Reedly.Database.Test.LinkTestHelper do
  @moduledoc "Test helpers functions for link"

  alias Reedly.Database.Link

  @attributes ~w[
    url
    description
    category_id
  ]a
  @created_link_attributes [:id | @attributes]

  defp attributes(links) when is_list(links),
    do: attributes(links, @attributes)

  defp attributes(links, attributes) when is_list(links),
    do: Enum.map(links, &attributes(&1, attributes))

  defp attributes(%Link{} = link), do: attributes(link, @attributes)
  defp attributes(%Link{} = link, attributes), do: Map.take(link, attributes)

  def equal?(links_1, links_2) when is_list(links_1) and is_list(links_2),
    do: attributes(links_1, @created_link_attributes) == attributes(links_2, @created_link_attributes)

  def equal?(%Link{} = link_1, %Link{} = link_2),
    do: attributes(link_1, @created_link_attributes) == attributes(link_2, @created_link_attributes)

  def equal?(%Link{} = link, attributes), do: attributes(link) == attributes
end
