defmodule Reedly.Core.Repositories.FeedEntryRepository do
  @moduledoc "Functions to read and manipulate feed entry"

  alias Reedly.Core.{Repo, FeedEntry}

  @doc "Returns all feed entries"
  @spec all() :: list(FeedEntry.t())
  def all, do: Repo.all(FeedEntry)
end
