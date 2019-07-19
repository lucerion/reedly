defmodule Reedly.API.Types.FeedType do
  @moduledoc "Feed type"

  use Absinthe.Schema.Notation

  @desc "Feed type"
  object :feed do
    field(:id, :integer)
    field(:title, :string)
    field(:url, :string)
    field(:feed_url, :string)
    field(:updated, :naive_datetime)
    field(:entries, list_of(:feed_entry))
  end

  @desc "Feed result type"
  object :feed_result do
    field(:result, :feed)
    field(:errors, list_of(:error))
  end
end
