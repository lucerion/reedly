defmodule Reedly.Database.Feed do
  @moduledoc "Feed model"

  use Ecto.Schema

  import Ecto.Changeset
  import Reedly.Database.Validators.CategoryValidator

  alias Reedly.Database.{Repo, Category, FeedEntry}

  @typedoc "Feed model type"
  @type t :: %__MODULE__{
          title: String.t(),
          url: String.t(),
          feed_url: String.t(),
          updated: NaiveDateTime.t()
        }

  @type id :: String.t() | integer

  @typedoc "Feed creation attributes types"
  @type create_attributes :: %{
          title: String.t(),
          url: String.t(),
          feed_url: String.t(),
          updated: NaiveDateTime.t(),
          category_id: Category.id()
        }

  @typedoc "Feed update attributes types"
  @type update_attributes :: %{
          title: String.t(),
          updated: NaiveDateTime.t(),
          category_id: Category.id()
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

  @spec create_changeset(%__MODULE__{}, create_attributes) :: Ecto.Changeset.t()
  def create_changeset(%__MODULE__{} = feed, attributes) do
    feed
    |> cast(attributes, @create_allowed_attributes)
    |> validate_required(@create_required_attributes)
    |> validate_category(@allowed_category_type)
    |> unique_constraint(:feed_url)
    |> cast_assoc(:entries, with: &FeedEntry.create_changeset/2)
  end

  @spec update_changeset(%__MODULE__{}, update_attributes) :: Ecto.Changeset.t()
  def update_changeset(%__MODULE__{} = feed, attributes) do
    feed
    |> Repo.preload(:entries)
    |> cast(attributes, @update_allowed_attributes)
    |> validate_category(@allowed_category_type)
    |> put_assoc(:entries, entries(feed, attributes))
  end

  defp entries(feed, attributes),
    do: Enum.uniq_by(feed.entries ++ Map.get(attributes, :entries, []), & &1.entity_id)
end
