defmodule Reedly.Database.Category do
  @moduledoc "Category model"

  use Ecto.Schema

  import Ecto.Changeset

  alias Reedly.Database.{Category, Feed}

  @typedoc "Category model type"
  @type t :: %__MODULE__{
          name: String.t(),
          type: String.t()
        }

  @types ~w[feed link]

  @create_allowed_attributes ~w[name type]a
  @create_required_attributes ~w[name type]a

  @update_allowed_attributes ~w[name]a
  @update_required_attributes ~w[name]a

  schema "categories" do
    field(:name, :string)
    field(:type, :string)

    has_many(:feeds, Feed, on_delete: :nilify_all)

    timestamps()
  end

  @spec create_changeset(%Category{}, map) :: Ecto.Changeset.t()
  def create_changeset(%Category{} = category, attributes \\ %{}) do
    category
    |> cast(attributes, @create_allowed_attributes)
    |> validate_required(@create_required_attributes)
    |> validate_inclusion(:type, @types)
    |> unique_constraint(:name, name: :categories_name_type_index)
  end

  @spec update_changeset(%Category{}, map) :: Ecto.Changeset.t()
  def update_changeset(%Category{} = category, attributes) do
    category
    |> cast(attributes, @update_allowed_attributes)
    |> validate_required(@update_required_attributes)
    |> unique_constraint(:name, name: :categories_name_type_index)
  end
end
