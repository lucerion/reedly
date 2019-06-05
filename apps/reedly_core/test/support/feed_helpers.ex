defmodule Reedly.Core.Test.FeedHelpers do
  @moduledoc "Test helpers functions for feed"

  alias Reedly.Core.{Repo, Feed}
  alias Reedly.Core.Test.{FeedEntryHelpers, Helpers}

  @attributes ~w[
    title
    url
    feed_url
    updated
  ]a

  @attributes_with_relations ~w[
    title
    url
    feed_url
    updated
    entries
  ]a

  @doc "Get feed attributes"
  def attributes(%Feed{} = feed) do
    feed
    |> Map.take(@attributes_with_relations)
    |> Map.update(:entries, [], &FeedEntryHelpers.attributes(&1))
  end

  @doc "Build feed attributes"
  def build_attributes(entries: entries) do
    %{
      title: Faker.Name.title(),
      url: Faker.Internet.url(),
      feed_url: Faker.Internet.url(),
      updated: Helpers.random_naive_date_time(truncate: :second),
      entries: entries
    }
  end

  def build_attributes(entries_count: entries_count) when entries_count <= 0,
    do: build_attributes(entries: [])

  def build_attributes(entries_count: entries_count) do
    entries = FeedEntryHelpers.build_attributes(count: entries_count)
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

  def create(attributes) do
    %Feed{}
    |> Ecto.Changeset.cast(attributes, @attributes)
    |> Ecto.Changeset.cast_assoc(:entries)
    |> Repo.insert()
  end
end
