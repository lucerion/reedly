defmodule Reedly.API.Queries.FeedQueries do
  @moduledoc "Feed queries"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.FeedResolver

  object :feed_queries do
    @desc "Feeds"
    field :feeds, type: list_of(:feed) do
      resolve(&FeedResolver.fetch/3)
    end
  end
end
