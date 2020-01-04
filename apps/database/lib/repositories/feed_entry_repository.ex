defmodule Reedly.Database.Repositories.FeedEntryRepository do
  @moduledoc "Functions to read and change feed entries in the database"

  import Ecto.Query

  alias Reedly.Database.{Repo, FeedEntry}

  @type id :: integer | String.t()
  @type feed_entries :: list(FeedEntry.t())

  @doc "Fetches a feed entry by id"
  @spec find(id) :: FeedEntry.t() | nil
  def find(id), do: Repo.get(FeedEntry, id)

  @doc "Fetches all feed entries"
  @spec all :: feed_entries | []
  def all, do: fetch(FeedEntry)

  @doc "Fetches read/unread feed entries by category"
  @spec filter(%{category_id: id, read: boolean}) :: feed_entries | []
  def filter(%{category_id: category_id, read: read}) do
    FeedEntry
    |> by_category_query(category_id)
    |> by_read_query(read)
    |> fetch()
  end

  @doc "Fetches feed entries by category"
  @spec filter(%{category_id: id}) :: feed_entries | []
  def filter(%{category_id: category_id}) do
    FeedEntry
    |> by_category_query(category_id)
    |> fetch()
  end

  @doc "Fetches read/unread feed entries by feed"
  @spec filter(%{feed_id: id, read: boolean}) :: feed_entries | []
  def filter(%{feed_id: feed_id, read: read}) do
    FeedEntry
    |> by_feed_query(feed_id)
    |> by_read_query(read)
    |> Repo.all()
  end

  @doc "Fetches feed entries by feed"
  @spec filter(%{feed_id: id}) :: feed_entries | []
  def filter(%{feed_id: feed_id}) do
    FeedEntry
    |> by_feed_query(feed_id)
    |> Repo.all()
  end

  @doc "Fetches read/unread feed entries"
  @spec filter(%{read: boolean}) :: feed_entries | []
  def filter(%{read: read}) do
    FeedEntry
    |> by_read_query(read)
    |> fetch()
  end

  @spec filter(%{}) :: []
  def filter(_attributes), do: []

  @doc "Updates a feed entry"
  @spec update(FeedEntry.t(), map) :: {:ok, FeedEntry.t()} | {:error, Ecto.Changeset.t()}
  def update(%FeedEntry{} = feed_entry, attributes) do
    feed_entry
    |> FeedEntry.update_changeset(attributes)
    |> Repo.update()
  end

  defp fetch(query) do
    query
    |> Repo.all()
    |> Repo.preload(:feed)
  end

  defp by_category_query(query, category_id) do
    query
    |> join(:left, [feed_entry], feed in assoc(feed_entry, :feed))
    |> join(:left, [_feed_entry, feed], category in assoc(feed, :category))
    |> by_category_id_query(category_id)
  end

  defp by_category_id_query(query, nil),
    do: where(query, [_feed_entry, _feed, category], is_nil(category.id))

  defp by_category_id_query(query, category_id),
    do: where(query, [_feed_entry, _feed, category], category.id == ^category_id)

  defp by_feed_query(query, feed_id), do: where(query, feed_id: ^feed_id)

  defp by_read_query(query, read), do: where(query, read: ^read)
end
