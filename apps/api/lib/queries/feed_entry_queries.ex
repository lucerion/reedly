defmodule Reedly.API.Queries.FeedEntryQueries do
  @moduledoc "Feed entry queries"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.FeedEntryResolver

  object :feed_entry_queries do
    @desc "All feed entries"
    field :feed_entries, type: list_of(:feed_entry) do
      resolve(&FeedEntryResolver.all/3)
    end
  end
end
