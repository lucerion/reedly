defmodule Reedly.Database.Category do
  @moduledoc "Category model"

  use Ecto.Schema

  import Ecto.Changeset

  alias Reedly.Database.{Feed, Link}

  @typedoc "Category model type"
  @type t :: %__MODULE__{
          name: String.t(),
          type: String.t()
        }

  @type id :: String.t() | integer

  @typedoc "Category creation attributes types"
  @type create_attributes :: %{
          name: String.t(),
          type: String.t()
        }

  @typedoc "Category update attributes types"
  @type update_attributes :: %{
          id: id,
          name: String.t()
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
    has_many(:links, Link, on_delete: :nilify_all)

    timestamps()
  end

  @spec create_changeset(%__MODULE__{}, create_attributes) :: Ecto.Changeset.t()
  def create_changeset(%__MODULE__{} = category, attributes) do
    category
    |> cast(attributes, @create_allowed_attributes)
    |> validate_required(@create_required_attributes)
    |> validate_inclusion(:type, @types)
    |> unique_constraint(:name, name: :categories_name_type_index)
  end

  @spec update_changeset(%__MODULE__{}, update_attributes) :: Ecto.Changeset.t()
  def update_changeset(%__MODULE__{} = category, attributes) do
    category
    |> cast(attributes, @update_allowed_attributes)
    |> validate_required(@update_required_attributes)
    |> unique_constraint(:name, name: :categories_name_type_index)
  end
end
