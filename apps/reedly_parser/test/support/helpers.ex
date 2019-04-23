defmodule Reedly.Parser.Test.Helpers do
  @moduledoc "Tests helper functions"

  @default_date_time_format "%a, %d %b %Y %H:%M:%S %z"

  alias Reedly.Parser.Helpers.DateTimeHelper

  @doc "Feed attributes"
  def feed_attributes(feed) do
    %{
      title: feed.title,
      url: feed.link,
      updated: DateTimeHelper.parse(feed.updated),
      entries: Enum.map(feed.entries, &feed_entry_attributes(&1))
    }
  end

  @doc "Feed entry attributes"
  def feed_entry_attributes(feed_entry) do
    %{
      title: feed_entry.title,
      content: feed_entry.summary,
      url: feed_entry.link,
      entity_id: feed_entry.id,
      published: DateTimeHelper.parse(feed_entry.updated)
    }
  end

  def format_date_time(date_time, format \\ @default_date_time_format) do
    case Timex.format(date_time, format, :strftime) do
      {:ok, date_time_string} -> date_time_string
      _ -> nil
    end
  end
end
