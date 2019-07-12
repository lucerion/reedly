defmodule Reedly.Core.FeedEntries do
  @moduledoc "Feed entries related business logic"

  alias Reedly.Core.{FeedEntry, Repositories.FeedEntryRepository}

  @doc "All feed entries"
  @spec all(map) :: list(FeedEntry.t())
  def all(attributes \\ %{}), do: FeedEntryRepository.all()

  @doc "Update a feed entry"
  @spec update(map) :: {:ok, FeedEntry.t()} | {:error, Ecto.Changeset.t()} | {:error, nil}
  def update(%{id: id} = attributes) do
    case FeedEntryRepository.find(id) do
      nil -> {:error, nil}
      feed_entry -> FeedEntryRepository.update(feed_entry, attributes)
    end
  end
end