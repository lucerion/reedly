defmodule Reedly.Parser.Mappers.FeedMapper do
  @moduledoc "Feed mapper maps parsed feed to a feed attributes"

  alias FeederEx.Feed
  alias Reedly.Parser.{Mappers.FeedEntryMapper, Helpers.DateTimeHelper}

  @typedoc "FeederEx.Feed type"
  @type feeder_ex_feed :: %Feed{
          title: String.t(),
          summary: String.t(),
          link: String.t(),
          updated: String.t(),
          entries: list(FeedEntryMapper.feeder_ex_entry())
        }

  @typedoc "Feed attributes type"
  @type feed_attributes :: %{
          title: String.t(),
          description: String.t(),
          site: String.t(),
          updated: NaiveDateTime.t(),
          entries: list(FeedEntryMapper.feed_entry_attributes())
        }

  @doc "Maps a parsed feed to a feed attributes"
  @spec map(feeder_ex_feed) :: feed_attributes
  def map(%Feed{title: title, summary: summary, link: link, updated: updated, entries: entries}) do
    %{
      title: title,
      description: summary,
      site: link,
      updated: DateTimeHelper.parse(updated),
      entries: FeedEntryMapper.map(entries)
    }
  end
end
