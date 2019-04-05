defmodule Reedly.Core.FeedEntry do
  @moduledoc "RSS/Atom feed entry representation"

  use Ecto.Schema

  import Ecto.Changeset

  alias Reedly.Core.{FeedEntry, Feed}

  @typedoc "FeedEntry model type"
  @type t :: %__MODULE__{
          title: String.t(),
          summary: String.t(),
          url: String.t(),
          updated: NaiveDateTime.t(),
          read: boolean
        }

  @allowed_attributes ~w[
    title
    summary
    url
    updated
    read
  ]a

  schema "feed_entries" do
    field(:title, :string)
    field(:summary, :string)
    field(:url, :string)
    field(:updated, :naive_datetime)
    field(:read, :boolean, default: false)

    belongs_to(:feed, Feed)

    timestamps()
  end

  @spec changeset(%FeedEntry{}, map) :: Ecto.Changeset.t()
  def changeset(model, attributes \\ %{}) do
    model
    |> cast(attributes, @allowed_attributes)
  end
end
