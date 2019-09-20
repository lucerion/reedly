defmodule Reedly.Database.Test.FeedTestHelper do
  @moduledoc "Test helpers functions for feed"

  import Ecto.Query

  alias Reedly.Database.{Repo, Feed}
  alias Reedly.Database.Test.FeedEntryTestHelper

  @attributes ~w[
    title
    url
    feed_url
    updated
    category_id
    entries
  ]a
  @attributes_with_id [:id | @attributes]

  defp attributes(feeds, attributes) when is_list(feeds),
    do: Enum.map(feeds, &attributes(&1, attributes))

  defp attributes(%Feed{} = feed), do: attributes(feed, @attributes)

  defp attributes(%Feed{} = feed, attributes) do
    feed
    |> Repo.preload([:category, :entries])
    |> Map.take(attributes)
    |> Map.update(:entries, [], &FeedEntryTestHelper.attributes(&1))
  end

  def equal?(feeds_1, feeds_2) when is_list(feeds_1) and is_list(feeds_2),
    do: attributes(feeds_1, @attributes_with_id) == attributes(feeds_2, @attributes_with_id)

  def equal?(%Feed{} = feed_1, %Feed{} = feed_2),
    do: attributes(feed_1, @attributes_with_id) == attributes(feed_2, @attributes_with_id)

  def equal?(%Feed{} = feed, attributes), do: attributes(feed) == attributes

  def find_by_ids(ids) do
    Feed
    |> where([feed], feed.id in ^ids)
    |> Repo.all()
  end
end
