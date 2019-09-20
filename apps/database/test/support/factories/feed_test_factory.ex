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

  def build_attributes(attributes, entries_count: entries_count) do
    build_attributes(entries_count: entries_count)
    |> Map.merge(attributes)
  end

  @doc "Create a feed"
  def create(attributes) when is_map(attributes) do
    %Feed{}
    |> Ecto.Changeset.cast(build_attributes(attributes), @attributes)
    |> Ecto.Changeset.cast_assoc(:entries, with: &FeedEntry.create_changeset/2)
    |> insert()
  end

  def create(attributes, entries: entries) do
    %Feed{}
    |> Ecto.Changeset.cast(build_attributes(attributes), @attributes)
    |> Ecto.Changeset.put_assoc(:entries, entries)
    |> insert()
  end

  def create(attributes, entries_count: entries_count) do
    attributes
    |> build_attributes(entries_count: entries_count)
    |> create()
  end

  def create(entries: entries) do
    %Feed{}
    |> Ecto.Changeset.cast(build_attributes(), @attributes)
    |> Ecto.Changeset.put_assoc(:entries, entries)
    |> insert()
  end

  def create(entries_count: entries_count) do
    build_attributes(entries_count: entries_count)
    |> create()
  end

  defp insert(changeset) do
    changeset
    |> Repo.insert()
    |> extract_result()
    |> Repo.preload([:category, :entries])
  end
end
