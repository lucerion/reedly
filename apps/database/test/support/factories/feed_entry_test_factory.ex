defmodule Reedly.Database.Test.FeedEntryTestFactory do
  @moduledoc "Feed entry factories for tests"

  use Reedly.Database.Test.TestFactory

  alias Reedly.Database.{Repo, FeedEntry}
  alias Reedly.Database.Test.DateTimeTestHelper

  @attributes ~w[
    title
    content
    url
    entity_id
    published
    read
  ]a

  @doc "Builds feed entry attributes"
  def build_attributes do
    %{
      title: Faker.Name.title(),
      content: Faker.Lorem.paragraph(),
      url: Faker.Internet.url(),
      entity_id: Faker.Internet.slug(),
      published: DateTimeTestHelper.random_naive_date_time(truncate: :second),
      read: false
    }
  end

  @doc "Creates a feed entry"
  def create(attributes) when is_map(attributes) do
    %FeedEntry{}
    |> Ecto.Changeset.cast(build_attributes(attributes), @attributes)
    |> Repo.insert()
    |> extract_result()
  end
end
