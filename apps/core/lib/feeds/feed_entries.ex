defmodule Reedly.Core.Feeds.FeedEntries do
  @moduledoc "Feed entries related business logic"

  alias Reedly.Database.{FeedEntry, Repositories.FeedEntryRepository}

  @doc "All feed entries"
  @spec all() :: list(FeedEntry.t())
  def all, do: FeedEntryRepository.all()

  @doc "Feed entries by criteria"
  @spec filter(map) :: list(FeedEntry.t())
  def filter(attributes), do: FeedEntryRepository.filter(attributes)

  @spec filter() :: list(FeedEntry.t())
  def filter, do: []

  @doc "Updates a feed entry"
  @spec update(map) :: {:ok, FeedEntry.t()} | {:error, Ecto.Changeset.t()} | {:error, nil}
  def update(%{id: id} = attributes) do
    case FeedEntryRepository.find(id) do
      nil -> {:error, nil}
      feed_entry -> FeedEntryRepository.update(feed_entry, attributes)
    end
  end
end
