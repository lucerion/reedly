defmodule Reedly.Database.FeedEntry do
  @moduledoc "Feed entry model"

  use Ecto.Schema

  import Ecto.Changeset

  alias Reedly.Database.Feed

  @typedoc "FeedEntry model type"
  @type t :: %__MODULE__{
          title: String.t(),
          content: String.t(),
          url: String.t(),
          entity_id: String.t(),
          published: NaiveDateTime.t(),
          read: boolean
        }

  @type id :: String.t() | integer

  @typedoc "FeedEntry creation attributes types"
  @type create_attributes :: %{
          title: String.t(),
          content: String.t(),
          url: String.t(),
          entity_id: String.t(),
          published: NaiveDateTime.t(),
          read: boolean
        }

  @typedoc "FeedEntry update attributes types"
  @type update_attributes :: %{id: id, read: boolean}

  @create_allowed_attributes ~w[
    title
    content
    url
    entity_id
    published
    read
  ]a
  @create_required_attributes ~w[
    title
    content
    entity_id
  ]

  @update_allowed_attributes ~w[read]a

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

  @spec create_changeset(%__MODULE__{}, create_attributes) :: Ecto.Changeset.t()
  def create_changeset(%__MODULE__{} = feed_entry, attributes) do
    feed_entry
    |> cast(attributes, @create_allowed_attributes)
    |> validate_required(@create_required_attributes)
  end

  @spec update_changeset(%__MODULE__{}, update_attributes) :: Ecto.Changeset.t()
  def update_changeset(%__MODULE__{} = feed_entry, attributes) do
    feed_entry
    |> cast(attributes, @update_allowed_attributes)
  end
end
