defmodule Reedly.API.Mutations.FeedMutations do
  @moduledoc "Feed mutations"

  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias Reedly.API.Resolvers.FeedResolver

  payload_object(:feed_result, :feed)

  object :feed_mutations do
    @desc "Create feed"
    field :create_feed, type: :feed_result do
      arg(:feed_url, non_null(:string))

      resolve(&FeedResolver.create/3)
      middleware(&build_payload/2)
    end
  end
end
