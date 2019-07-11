defmodule Reedly.Core.Test.FeederExTestHelper do
  @moduledoc "FeederEx helpers functions"

  alias Reedly.Core.Helpers.DateTimeHelper
  alias Reedly.Core.Test.TestHelper

  @doc "Build FeederEx.Feed"
  def build_feed, do: build_feed(entries: [])

  def build_feed(entries: entries) do
    %FeederEx.Feed{
      title: Faker.Name.title(),
      link: Faker.Internet.url(),
      updated: DateTime.utc_now() |> TestHelper.format_date_time(),
      entries: entries
    }
  end

  def build_feed(entries_count: entries_count) when entries_count < 0,
    do: build_feed()

  def build_feed(entries_count: entries_count) do
    entries = build_entry(count: entries_count)
    build_feed(entries: entries)
  end

  @doc "Build FeederEx.Entry"
  def build_entry(count: count) when count < 0, do: []

  def build_entry(count: count),
    do: Enum.map(0..(count - 1), fn _x -> build_entry() end)

  def build_entry do
    %FeederEx.Entry{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(),
      link: Faker.Internet.url(),
      id: Faker.Internet.slug(),
      updated: DateTime.utc_now() |> TestHelper.format_date_time()
    }
  end

  @doc "Coverts FeederEx.Feed to Feed attributes"
  def to_feed_attributes(%FeederEx.Feed{title: title, link: link, updated: updated, entries: entries}) do
    %{
      title: title,
      url: link,
      updated: DateTimeHelper.parse(updated),
      entries: to_feed_entry_attributes(entries)
    }
  end

  @doc "Coverts FeederEx.Entries to FeedEntry attributes"
  def to_feed_entry_attributes(entries) when is_list(entries),
    do: Enum.map(entries, &to_feed_entry_attributes(&1))

  @doc "Coverts FeederEx.Entry to FeedEntry attributes"
  def to_feed_entry_attributes(%FeederEx.Entry{title: title, summary: summary, link: link, id: id, updated: updated}) do
    %{
      title: title,
      content: summary,
      url: link,
      entity_id: id,
      published: DateTimeHelper.parse(updated)
    }
  end
end
