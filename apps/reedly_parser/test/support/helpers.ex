defmodule Reedly.Parser.Test.Helpers do
  @moduledoc "Tests helper functions"

  def feed_attributes(feed) do
    %{
      title: feed.title,
      description: feed.summary,
      url: feed.link,
      site: feed.url,
      updated: feed.updated,
      entries: Enum.map(feed.entries, &feed_entry_attributes(&1))
    }
  end

  def feed_entry_attributes(feed_entry) do
    %{
      title: feed_entry.title,
      summary: feed_entry.summary,
      url: feed_entry.link,
      updated: feed_entry.updated
    }
  end
end
