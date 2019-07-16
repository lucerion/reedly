defmodule Reedly.Database.Test.CategoryTestHelper do
  @moduledoc "Test helpers functions for category"

  alias Reedly.Database.{Repo, Category}

  @attributes ~w[
    name
    type
  ]a

  @full_attributes [:id | @attributes]

  @doc "Get category attributes"
  def attributes(%Category{} = category), do: attributes(category, @attributes)
  def attributes(%Category{} = category, attributes), do: Map.take(category, attributes)

  @doc "Build category attributes"
  def build_attributes do
    %{
      name: Faker.Name.title(),
      type: "feed"
    }
  end

  def build_attributes(attributes), do: Map.merge(build_attributes(), attributes)

  @doc "Create a category"
  def create, do: create(%{})

  def create(attributes) do
    full_attributes = Map.merge(build_attributes(), attributes)

    %Category{}
    |> Ecto.Changeset.cast(full_attributes, @attributes)
    |> Repo.insert()
  end

  def equal?(%Category{} = category_1, %Category{} = category_2),
    do: attributes(category_1, @full_attributes) == attributes(category_2, @full_attributes)

  def equal?(%Category{} = category, attributes), do: attributes(category) == attributes
end
