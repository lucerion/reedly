defmodule Reedly.API.Types.FeedType do
  @moduledoc "Feed type"

  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias Reedly.API.Resolvers.FeedResolver

  @desc "Feed type"
  object :feed do
    field(:id, :integer)
    field(:title, :string)
    field(:url, :string)
    field(:feed_url, :string)
    field(:updated, :naive_datetime)
    field(:entries, list_of(:feed_entry))
  end

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
