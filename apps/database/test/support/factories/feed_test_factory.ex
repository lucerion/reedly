defmodule Reedly.Database.Test.FeedTestFactory do
  @moduledoc "Feed factories for tests"

  use Reedly.Database.Test.TestFactory

  alias Reedly.Database.{Repo, Feed, FeedEntry}
  alias Reedly.Database.Test.{DateTimeTestHelper, FeedEntryTestFactory}

  @attributes ~w[
    title
    url
    feed_url
    updated
    category_id
  ]a

  @doc "Builds feed attributes"
  def build_attributes do
    %{
      title: Faker.Name.title(),
      url: Faker.Internet.url(),
      feed_url: Faker.Internet.url(),
      updated: DateTimeTestHelper.random_naive_date_time(truncate: :second),
      entries: [],
      category_id: nil
    }
  end

  def build_attributes(entries: entries), do: build_attributes(%{entries: entries})

  def build_attributes(entries_count: entries_count) when entries_count <= 0,
    do: build_attributes()

  def build_attributes(entries_count: entries_count) do
    entries = FeedEntryTestFactory.build_attributes(count: entries_count)
    build_attributes(entries: entries)
  end

  @doc "Create a feed"
  def create(attributes) when is_map(attributes) do
    %Feed{}
    |> Ecto.Changeset.cast(build_attributes(attributes), @attributes)
    |> Ecto.Changeset.cast_assoc(:entries, with: &FeedEntry.create_changeset/2)
    |> Repo.insert()
    |> extract_result()
  end

  def create(entries: entries) do
    build_attributes(entries: entries)
    |> create()
  end

  def create(entries_count: entries_count) do
    build_attributes(entries_count: entries_count)
    |> create()
  end
end
