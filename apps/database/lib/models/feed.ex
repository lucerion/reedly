defmodule Reedly.Database.Feed do
  @moduledoc "Feed model"

  use Ecto.Schema

  import Ecto.Changeset
  import Reedly.Database.Validators.CategoryValidator

  alias Reedly.Database.{Repo, Feed, Category, FeedEntry}

  @typedoc "Feed model type"
  @type t :: %__MODULE__{
          title: String.t(),
          url: String.t(),
          feed_url: String.t(),
          updated: NaiveDateTime.t()
        }

  @create_allowed_attributes ~w[
    title
    url
    feed_url
    updated
    category_id
  ]a
  @create_required_attributes ~w[feed_url]a

  @update_allowed_attributes ~w[
    title
    updated
    category_id
  ]a

  @allowed_category_type "feed"

  schema "feeds" do
    field(:title, :string)
    field(:url, :string)
    field(:feed_url, :string)
    field(:updated, :naive_datetime)

    belongs_to(:category, Category)
    has_many(:entries, FeedEntry, on_delete: :delete_all)

    timestamps()
  end

  @spec create_changeset(%Feed{}, map) :: Ecto.Changeset.t()
  def create_changeset(%Feed{} = feed, attributes \\ %{}) do
    feed
    |> cast(attributes, @create_allowed_attributes)
    |> validate_required(@create_required_attributes)
    |> validate_category(@allowed_category_type)
    |> unique_constraint(:feed_url)
    |> cast_assoc(:entries, with: &FeedEntry.create_changeset/2)
  end

  @spec update_changeset(%Feed{}, map) :: Ecto.Changeset.t()
  def update_changeset(%Feed{} = feed, attributes) do
    new_entries = Map.get(attributes, :entries, [])

    feed
    |> Repo.preload(:entries)
    |> cast(attributes, @update_allowed_attributes)
    |> validate_category(@allowed_category_type)
    |> put_assoc(:entries, feed.entries ++ new_entries)
  end
end
