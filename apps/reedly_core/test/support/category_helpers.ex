defmodule Reedly.Core.Test.CategoryHelpers do
  @moduledoc "Test helpers functions for category"

  alias Reedly.Core.{Repo, Category}

  @attributes ~w[
    name
    type
  ]a

  @doc "Get category attributes"
  def attributes(%Category{} = category), do: Map.take(category, @attributes)

  @doc "Build category attributes"
  def build_attributes do
    %{
      name: Faker.Name.title(),
      type: "feed"
    }
  end

  def build_attributes(attributes), do: Map.merge(build_attributes(), attributes)

  @doc "Create a category"
  def create(attributes \\ %{}) do
    full_attributes = Map.merge(build_attributes(), attributes)

    %Category{}
    |> Ecto.Changeset.cast(full_attributes, @attributes)
    |> Repo.insert()
  end
end
