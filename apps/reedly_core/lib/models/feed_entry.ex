defmodule Reedly.Core.FeedEntry do
  @moduledoc "Feed entry model"

  use Ecto.Schema

  import Ecto.Changeset

  alias Reedly.Core.{FeedEntry, Feed}

  @typedoc "FeedEntry model type"
  @type t :: %__MODULE__{
          title: String.t(),
          content: String.t(),
          url: String.t(),
          entity_id: String.t(),
          published: NaiveDateTime.t(),
          read: boolean
        }

  @allowed_attributes ~w[
    title
    content
    url
    entity_id
    published
    read
  ]a

  schema "feed_entries" do
    field(:title, :string)
    field(:content, :string)
    field(:url, :string)
    field(:entity_id, :string)
    field(:published, :naive_datetime)
    field(:read, :boolean, default: false)

    belongs_to(:feed, Feed)

    timestamps()
  end

  @spec changeset(%FeedEntry{}, map) :: Ecto.Changeset.t()
  def changeset(%FeedEntry{} = feed_entry, attributes \\ %{}) do
    feed_entry
    |> cast(attributes, @allowed_attributes)
  end
end
