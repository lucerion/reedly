defmodule Reedly.Core.Test.FeederExHelpers do
  @moduledoc "FeederEx helpers functions"

  alias Reedly.Core.Helpers.DateTimeHelper
  alias Reedly.Core.Test.Helpers

  @doc "Build FeederEx.Feed struct with data"
  def build_feed(entries \\ []) do
    %FeederEx.Feed{
      title: Faker.Name.title(),
      link: Faker.Internet.url(),
      updated: DateTime.utc_now() |> Helpers.format_date_time(),
      entries: entries
    }
  end

  @doc "Build FeederEx.Entry struct with data"
  def build_entry do
    %FeederEx.Entry{
      title: Faker.Name.title(),
      summary: Faker.Lorem.paragraph(),
      link: Faker.Internet.url(),
      id: Faker.Internet.slug(),
      updated: DateTime.utc_now() |> Helpers.format_date_time()
    }
  end

  @doc "Coverts FeederEx.Feed to Feed attributes"
  def to_feed_attributes(feeder_ex_feed) do
    %{
      title: feeder_ex_feed.title,
      url: feeder_ex_feed.link,
      updated: DateTimeHelper.parse(feeder_ex_feed.updated),
      entries: Enum.map(feeder_ex_feed.entries, &to_feed_entry_attributes(&1))
    }
  end

  @doc "Coverts FeederEx.Entry to FeedEntry attributes"
  def to_feed_entry_attributes(feeder_ex_entry) do
    %{
      title: feeder_ex_entry.title,
      content: feeder_ex_entry.summary,
      url: feeder_ex_entry.link,
      entity_id: feeder_ex_entry.id,
      published: DateTimeHelper.parse(feeder_ex_entry.updated)
    }
  end
end
