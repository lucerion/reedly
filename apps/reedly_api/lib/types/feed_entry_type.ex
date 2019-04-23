defmodule Reedly.API.Types.FeedEntryType do
  @moduledoc "Feed entry type"

  use Absinthe.Schema.Notation

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
      resolve(&Reedly.API.Resolvers.FeedEntryResolver.all/3)
    end
  end
end
