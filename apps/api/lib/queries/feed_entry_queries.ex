defmodule Reedly.API.Queries.FeedEntryQueries do
  @moduledoc "Feed entry queries"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.FeedEntryResolver

  object :feed_entry_queries do
    @desc "Feed entries"
    field :feed_entries, type: list_of(:feed_entry) do
      arg(:feed_id, :integer)
      arg(:category_id, :integer)
      arg(:read, :boolean)

      resolve(&FeedEntryResolver.fetch/3)
    end
  end
end
