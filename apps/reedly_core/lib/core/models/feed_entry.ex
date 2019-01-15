defmodule Reedly.Core.FeedEntry do
  @moduledoc "RSS/Atom feed entry representation"

  use Ecto.Schema

  alias Reedly.Core.Feed

  @typedoc "FeedEntry model type"
  @type t :: %__MODULE__{
          title: String.t(),
          summary: String.t(),
          url: String.t(),
          updated: NaiveDateTime.t(),
          read: boolean
        }

  schema "feed_entries" do
    field(:title, :string)
    field(:summary, :string)
    field(:url, :string)
    field(:updated, :naive_datetime)
    field(:read, :boolean, default: false)

    belongs_to(:feed, Feed)

    timestamps()
  end
end
