defmodule Reedly.Database.Test.FeedTestHelper do
  @moduledoc "Test helpers functions for feed"

  import Ecto.Query

  alias Reedly.Database.{Repo, Feed, FeedEntry}
  alias Reedly.Database.Test.{DateTimeTestHelper, FeedEntryTestHelper}

  @attributes ~w[
    title
    url
    feed_url
    updated
    category_id
  ]a
  @attributes_with_relations [:entries | @attributes]
  @full_attributes [:id | @attributes_with_relations]

  @doc "A list of feeds attributes"
  def attributes(feeds, attributes) when is_list(feeds),
    do: Enum.map(feeds, &attributes(&1, attributes))

  @doc "Get feed attributes"
  def attributes(%Feed{} = feed), do: attributes(feed, @attributes_with_relations)

  def attributes(%Feed{} = feed, attributes) do
    feed
    |> Map.take(attributes)
    |> Map.update(:entries, [], &FeedEntryTestHelper.attributes(&1))
  end

  @doc "Build feed attributes"
  def build_attributes, do: build_attributes(entries: [])

  def build_attributes(entries: entries) do
    %{
      title: Faker.Name.title(),
      url: Faker.Internet.url(),
      feed_url: Faker.Internet.url(),
      updated: DateTimeTestHelper.random_naive_date_time(truncate: :second),
      entries: entries,
      category_id: nil
    }
  end

  def build_attributes(entries_count: entries_count) when entries_count <= 0,
    do: build_attributes()

  def build_attributes(entries_count: entries_count) do
    entries = FeedEntryTestHelper.build_attributes(count: entries_count)
    build_attributes(entries: entries)
  end

  @doc "Create a feed"
  def create(entries_count: entries_count) do
    build_attributes(entries_count: entries_count)
    |> create()
  end

  def create(entries: entries) do
    build_attributes(entries: entries)
    |> create()
  end

  def create, do: create(%{})

  def create(attributes) do
    full_attributes = Map.merge(build_attributes(), attributes)

    %Feed{}
    |> Ecto.Changeset.cast(full_attributes, @attributes)
    |> Ecto.Changeset.cast_assoc(:entries, with: &FeedEntry.create_changeset/2)
    |> Repo.insert()
  end

  def create(attributes, count: count) when count <= 0,
    do: create(attributes)

  def create(attributes, count: count) do
    0..(count - 1)
    |> Enum.map(fn _x -> create(attributes) end)
    |> Enum.map(fn {:ok, feed} -> feed end)
  end

  def equal?(feeds_1, feeds_2) when is_list(feeds_1) and is_list(feeds_2),
    do: attributes(feeds_1, @full_attributes) == attributes(feeds_2, @full_attributes)

  def equal?(%Feed{} = feed, attributes), do: attributes(feed) == attributes

  def find_by_ids(ids),
    do: Repo.all(from(feed in Feed, where: feed.id in ^ids))
end
