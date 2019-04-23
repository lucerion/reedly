defmodule Reedly.Core.Test.FeedHelpers do
  @moduledoc "Test helpers functions for Feed"

  alias Reedly.Core.Test.FeedEntryHelpers
  alias Reedly.Core.{Repo, Feed}

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

  def attributes(feed) do
    feed
    |> Map.take(@attributes_with_relations)
    |> Map.update(:entries, [], &FeedEntryHelpers.attributes(&1))
  end

  def build_attributes(entries_attributes \\ []) do
    %{
      title: Faker.Name.title(),
      url: Faker.Internet.url(),
      feed_url: Faker.Internet.url(),
      updated: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      entries: entries_attributes
    }
  end

  def create(attributes \\ %{}, entries_attributes \\ []) do
    full_attributes = Map.merge(build_attributes(entries_attributes), attributes)

    %Feed{}
    |> Ecto.Changeset.cast(full_attributes, @attributes)
    |> Ecto.Changeset.cast_assoc(:entries)
    |> Repo.insert()
  end
end
