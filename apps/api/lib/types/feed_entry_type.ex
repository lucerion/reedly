defmodule Reedly.API.Types.FeedEntryType do
  @moduledoc "Feed entry type"

  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias Reedly.API.Resolvers.FeedEntryResolver

  @desc "Feed entry type"
  object :feed_entry do
    field(:id, :integer)
    field(:title, :string)
    field(:content, :string)
    field(:url, :string)
    field(:entity_id, :string)
    field(:published, :naive_datetime)
    field(:read, :boolean)
    field(:feed_id, :integer)
  end

  object :feed_entry_queries do
    @desc "All feed entries"
    field :feed_entries, type: list_of(:feed_entry) do
      resolve(&FeedEntryResolver.all/3)
    end
  end

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
