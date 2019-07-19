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

  @desc "Feed entry result type"
  object :feed_entry_result do
    field(:result, :feed_entry)
    field(:errors, list_of(:error))
  end
end
