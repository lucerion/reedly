defmodule Reedly.Core.Test.FeedTestHelper do
  @moduledoc "Test helpers functions for feed"

  import Ecto.Query

  alias Reedly.Core.{Repo, Feed, FeedEntry}
  alias Reedly.Core.Test.{TestHelper, FeedEntryTestHelper}

  @attributes ~w[
    title
    url
    feed_url
    updated
    category_id
  ]a

  @attributes_with_relations @attributes ++ ~w[entries]a

  @doc "Get feed attributes"
  def attributes(%Feed{} = feed) do
    feed
    |> Map.take(@attributes_with_relations)
    |> Map.update(:entries, [], &FeedEntryTestHelper.attributes(&1))
  end

  @doc "Build feed attributes"
  def build_attributes, do: build_attributes(entries: [])

  def build_attributes(entries: entries) do
    %{
      title: Faker.Name.title(),
      url: Faker.Internet.url(),
      feed_url: Faker.Internet.url(),
      updated: TestHelper.random_naive_date_time(truncate: :second),
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

  def create(attributes \\ %{}) do
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

  def find_by_ids(ids),
    do: Repo.all(from(feed in Feed, where: feed.id in ^ids))
end
