defmodule Reedly.Core.Feed do
  @moduledoc "RSS/Atom feed representation"

  use Ecto.Schema

  import Ecto.Changeset

  alias Reedly.Core.{Feed, FeedEntry}

  @typedoc "Feed model type"
  @type t :: %__MODULE__{
          title: String.t(),
          description: String.t(),
          url: String.t(),
          site: String.t(),
          updated: NaiveDateTime.t()
        }

  @fields ~w[
    title
    description
    url
    site
    updated
  ]a

  schema "feeds" do
    field(:title, :string)
    field(:description, :string)
    field(:url, :string)
    field(:site, :string)
    field(:updated, :naive_datetime)

    has_many(:entries, FeedEntry)

    timestamps()
  end

  @spec changeset(%Feed{}, map) :: Ecto.Changeset.t()
  def changeset(model, attributes \\ %{}) do
    model
    |> cast(attributes, @fields)
    |> cast_assoc(:entries)
  end
end
