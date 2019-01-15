defmodule Reedly.Core.Mappers.FeedMapper do
  @moduledoc "Feed mapper maps parsed feed to a feed attributes"

  alias FeederEx.Feed
  alias Reedly.Core.Mappers.FeedEntryMapper

  @typedoc "FeederEx.Feed type"
  @type feeder_ex_feed :: %Feed{
          title: String.t(),
          summary: String.t(),
          link: String.t(),
          id: String.t(),
          updated: String.t(),
          entries: list(FeedEntryMapper.feeder_ex_entry())
        }

  @typedoc "Feed attributes type"
  @type feed_attributes :: %{
          title: String.t(),
          description: String.t(),
          url: String.t(),
          site: String.t(),
          updated: String.t(),
          entries: list(FeedEntryMapper.feed_entry_attributes())
        }

  @doc "Maps a parsed feed to a feed attributes"
  @spec map(feeder_ex_feed) :: feed_attributes
  def map(%Feed{title: title, summary: summary, link: link, url: url, id: id, entries: entries, updated: updated}) do
    %{
      title: title,
      description: summary,
      url: link,
      site: url || id,
      updated: updated,
      entries: FeedEntryMapper.map(entries)
    }
  end
end
