defmodule Reedly.Core.Feed do
  @moduledoc "RSS/Atom feed representation"

  use Ecto.Schema

  alias Reedly.Core.FeedEntry

  @typedoc "Feed model type"
  @type t :: %__MODULE__{
          title: String.t(),
          description: String.t(),
          url: String.t(),
          site: String.t(),
          updated: NaiveDateTime.t()
        }

  schema "feeds" do
    field(:title, :string)
    field(:description, :string)
    field(:url, :string)
    field(:site, :string)
    field(:updated, :naive_datetime)

    has_many(:entries, FeedEntry)

    timestamps()
  end
end
