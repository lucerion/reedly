defmodule Reedly.Database.Test.FeedEntryTestHelper do
  @moduledoc "Test helpers functions for feed entry"

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

  @full_attributes [:id | @attributes]

  @doc "A list of feed entries attributes"
  def attributes(feed_entries) when is_list(feed_entries),
    do: attributes(feed_entries, @attributes)

  def attributes(feed_entries, attributes) when is_list(feed_entries),
    do: Enum.map(feed_entries, &attributes(&1, attributes))

  @doc "Get feed entry attributes"
  def attributes(%FeedEntry{} = feed_entry), do: attributes(feed_entry, @attributes)
  def attributes(%FeedEntry{} = feed_entry, attributes), do: Map.take(feed_entry, attributes)

  @doc "Build feed entry attributes"
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

  def build_attributes(count: count) when count <= 0,
    do: build_attributes()

  def build_attributes(count: count),
    do: Enum.map(0..(count - 1), fn _x -> build_attributes() end)

  @doc "Create a feed entry"
  def create(count: count) when count <= 0,
    do: create()

  def create(count: count) do
    0..(count - 1)
    |> Enum.map(fn _x -> create() end)
    |> Enum.map(fn {:ok, entry} -> entry end)
  end

  def create, do: create(%{})

  def create(attributes) do
    full_attributes = Map.merge(build_attributes(), attributes)

    %FeedEntry{}
    |> Ecto.Changeset.cast(full_attributes, @attributes)
    |> Repo.insert()
  end

  def equal?(entries_1, entries_2) when is_list(entries_1) and is_list(entries_2),
    do: attributes(entries_1, @full_attributes) == attributes(entries_2, @full_attributes)
end
