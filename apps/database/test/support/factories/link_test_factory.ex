defmodule Reedly.Database.Test.LinkTestFactory do
  @moduledoc "Link factories for tests"

  use Reedly.Database.Test.TestFactory

  alias Reedly.Database.{Link, Repo}

  @attributes ~w[
    url
    description
  ]a

  @doc "Builds link attributes"
  def build_attributes do
    %{
      url: Faker.Internet.url(),
      description: Faker.Name.title()
    }
  end

  @doc "Creates a link"
  def create(attributes) do
    %Link{}
    |> Ecto.Changeset.cast(build_attributes(attributes), @attributes)
    |> Repo.insert()
    |> extract_result()
  end
end
