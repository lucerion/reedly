defmodule Reedly.Database.Repositories.FeedEntryRepository do
  @moduledoc "Functions to read and change feed entries in the database"

  alias Reedly.Database.{Repo, FeedEntry}

  @doc "Find a feed entry by id"
  @spec find(integer | String.t()) :: FeedEntry.t() | nil
  def find(id), do: Repo.get(FeedEntry, id)

  @doc "All feed entries"
  @spec all :: list(FeedEntry.t())
  def all, do: Repo.all(FeedEntry)

  @doc "Update a feed entry"
  @spec update(FeedEntry.t(), map) :: {:ok, FeedEntry.t()} | {:error, Ecto.Changeset.t()}
  def update(%FeedEntry{} = feed_entry, attributes) do
    feed_entry
    |> FeedEntry.update_changeset(attributes)
    |> Repo.update()
  end
end
