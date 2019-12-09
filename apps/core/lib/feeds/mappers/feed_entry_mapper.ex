defmodule Reedly.Core.Feeds.Mappers.FeedEntryMapper do
  @moduledoc "Feed entry mapper maps parsed feed entry to a feed entry attributes"

  alias FeederEx.Entry
  alias Reedly.Core.Helpers.DateTimeHelper

  @typedoc "FeederEx.Entry type"
  @type feeder_ex_entry :: %Entry{
          title: String.t(),
          summary: String.t(),
          link: String.t(),
          id: String.t(),
          updated: String.t()
        }

  @typedoc "Feed entry attributes type"
  @type feed_entry_attributes :: %{
          title: String.t(),
          content: String.t(),
          url: String.t(),
          entity_id: String.t(),
          published: NaiveDateTime.t()
        }

  @doc "Maps a list of parsed feed entries to a feed entries attributes"
  @spec map(list(feeder_ex_entry) | []) :: list(feed_entry_attributes) | []
  def map(entries) when is_list(entries), do: Enum.map(entries, &map(&1))

  @doc "Maps a parsed feed entry to a feed entry attributes"
  @spec map(feeder_ex_entry) :: feed_entry_attributes()
  def map(%Entry{title: title, summary: summary, link: link, id: id, updated: updated}) do
    %{
      title: title,
      content: summary,
      url: link,
      entity_id: id,
      published: DateTimeHelper.parse(updated)
    }
  end
end
