defmodule Reedly.Core.Test.Helpers do
  @moduledoc "Tests helper functions"

  @feed_attributes ~w[
    title
    url
    feed_url
    updated
    entries
  ]a

  @feed_entry_attributes ~w[
    title
    summary
    url
    updated
    read
  ]a

  def feed_attributes(feed) do
    feed
    |> Map.take(@feed_attributes)
    |> Map.update(:entries, [], &feed_entry_attributes(&1))
  end

  defp feed_entry_attributes(feed_entry) when is_list(feed_entry),
    do: Enum.map(feed_entry, &feed_entry_attributes(&1))

  defp feed_entry_attributes(feed_entry),
    do: Map.take(feed_entry, @feed_entry_attributes)
end
