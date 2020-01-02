defmodule Reedly.Database.Test.FeedEntryTestHelper do
  @moduledoc "Test helpers functions for feed entry"

  alias Reedly.Database.FeedEntry

  @attributes ~w[
    title
    content
    url
    entity_id
    published
    read
  ]a
  @created_feed_entry_attributes [:id | @attributes]

  @doc "A list of feed entries attributes"
  def attributes(feed_entries) when is_list(feed_entries),
    do: attributes(feed_entries, @attributes)

  def attributes(feed_entries, attributes) when is_list(feed_entries),
    do: Enum.map(feed_entries, &attributes(&1, attributes))

  @doc "Get feed entry attributes"
  def attributes(feed_entry, attributes), do: Map.take(feed_entry, @attributes)

  def equal?(entries_1, entries_2) when is_list(entries_1) and is_list(entries_2),
    do: attributes(entries_1, @created_feed_entry_attributes) == attributes(entries_2, @created_feed_entry_attributes)
end
