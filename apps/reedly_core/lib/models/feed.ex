defmodule Reedly.Core.Feed do
  @moduledoc "RSS/Atom feed representation"

  use Ecto.Schema

  import Ecto.Changeset

  alias Reedly.Core.{Feed, FeedEntry}

  @typedoc "Feed model type"
  @type t :: %__MODULE__{
          title: String.t(),
          url: String.t(),
          feed_url: String.t(),
          updated: NaiveDateTime.t()
        }

  @allowed_attributes ~w[
    title
    url
    feed_url
    updated
  ]a

  schema "feeds" do
    field(:title, :string)
    field(:url, :string)
    field(:feed_url, :string)
    field(:updated, :naive_datetime)

    has_many(:entries, FeedEntry)

    timestamps()
  end

  @spec changeset(%Feed{}, map) :: Ecto.Changeset.t()
  def changeset(model, attributes \\ %{}) do
    model
    |> cast(attributes, @allowed_attributes)
    |> cast_assoc(:entries)
  end
end
