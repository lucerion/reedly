defmodule Reedly.API.Mutations.FeedMutations do
  @moduledoc "Feed mutations"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.FeedResolver

  object :feed_mutations do
    @desc "Create feed"
    field :create_feed, type: :feed_result do
      arg(:feed_url, non_null(:string))

      resolve(&FeedResolver.create/3)
    end
  end
end
