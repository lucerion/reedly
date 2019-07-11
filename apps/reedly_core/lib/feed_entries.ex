defmodule Reedly.Core.FeedEntries do
  @moduledoc "Feed entries related business logic"

  alias Reedly.Core.{FeedEntry, Repositories.FeedEntryRepository}

  @doc "All feed entries"
  @spec all(map()) :: list(FeedEntry.t())
  def all(attributes \\ %{}), do: FeedEntryRepository.all()
end
