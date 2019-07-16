defmodule Reedly.Database.Test.LinkTestHelper do
  @moduledoc "Test helpers functions for link"

  alias Reedly.Database.{Repo, Link}

  @attributes ~w[
    url
    description
  ]a

  @full_attributes [:id | @attributes]

  def attributes(links) when is_list(links),
    do: attributes(links, @attributes)

  def attributes(links, attributes) when is_list(links),
    do: Enum.map(links, &attributes(&1, attributes))

  @doc "Get link attributes"
  def attributes(%Link{} = link), do: attributes(link, @attributes)
  def attributes(%Link{} = link, attributes), do: Map.take(link, attributes)

  @doc "Build feed entry attributes"
  def build_attributes() do
    %{
      url: Faker.Internet.url(),
      description: Faker.Name.title()
    }
  end

  def build_attributes(attributes),
    do: Map.merge(build_attributes(), attributes)

  def create(count: count) when count <= 0,
    do: create()

  def create(count: count) do
    0..(count - 1)
    |> Enum.map(fn _x -> create() end)
    |> Enum.map(fn {:ok, link} -> link end)
  end

  def create, do: create(%{})

  def create(attributes) do
    full_attributes = Map.merge(build_attributes(), attributes)

    %Link{}
    |> Ecto.Changeset.cast(full_attributes, @attributes)
    |> Repo.insert()
  end

  def equal?(links_1, links_2) when is_list(links_1) and is_list(links_2),
    do: attributes(links_1, @full_attributes) == attributes(links_2, @full_attributes)

  def equal?(%Link{} = link_1, %Link{} = link_2),
    do: attributes(link_1, @full_attributes) == attributes(link_2, @full_attributes)

  def equal?(%Link{} = link, attributes), do: attributes(link) == attributes
end
