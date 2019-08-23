defmodule Reedly.Database.Test.CategoryTestFactory do
  @moduledoc "Category factories for tests"

  use Reedly.Database.Test.TestFactory

  alias Reedly.Database.{Repo, Category}

  @attributes ~w[
    name
    type
  ]a

  @doc "Builds category attributes"
  def build_attributes do
    %{
      name: Faker.Name.title(),
      type: "feed"
    }
  end

  @doc "Creates a category"
  def create(attributes) do
    %Category{}
    |> Ecto.Changeset.cast(build_attributes(attributes), @attributes)
    |> Repo.insert()
    |> extract_result()
  end
end
