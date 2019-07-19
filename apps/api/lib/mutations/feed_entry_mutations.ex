defmodule Reedly.API.Mutations.FeedEntryMutations do
  @moduledoc "Feed entry mutations"

  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias Reedly.API.Resolvers.FeedEntryResolver

  payload_object(:feed_entry_result, :feed_entry)

  object :feed_entry_mutations do
    @desc "Update a feed entry"
    field :update_feed_entry, type: :feed_entry_result do
      arg(:id, non_null(:integer))
      arg(:read, non_null(:boolean))

      resolve(&FeedEntryResolver.update/3)
      middleware(&build_payload/2)
    end
  end
end
