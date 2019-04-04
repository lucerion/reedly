defmodule Reedly.Core.Test.Helpers do
  @moduledoc "Tests helper functions"

  def feed_attributes_from_feed(feed) do
    feed
    |> Map.take(~w[title description url site updated entries]a)
    |> Map.update(:entries, [], &feed_entry_attributes_from_feed_entry(&1))
  end

  def feed_entry_attributes_from_feed_entry(feed_entry) when is_list(feed_entry),
    do: Enum.map(feed_entry, &feed_entry_attributes_from_feed_entry(&1))

  def feed_entry_attributes_from_feed_entry(feed_entry),
    do: Map.take(feed_entry, ~w[title summary url updated read]a)

  def feeder_ex_feed_to_feed_attributes(feed) do
    %{
      title: feed.title,
      description: feed.summary,
      url: feed.link,
      site: feed.url,
      updated: feed.updated,
      entries: Enum.map(feed.entries, &feeder_ex_entry_to_feed_entry_attributes(&1))
    }
  end

  def feeder_ex_entry_to_feed_entry_attributes(feed_entry) do
    %{
      title: feed_entry.title,
      summary: feed_entry.summary,
      url: feed_entry.link,
      updated: feed_entry.updated
    }
  end
end
