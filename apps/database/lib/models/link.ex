defmodule Reedly.Database.Link do
  @moduledoc "Link (web bookmark) model"

  use Ecto.Schema

  import Ecto.Changeset
  import Reedly.Database.Validators.CategoryValidator

  alias Reedly.Database.Category

  @typedoc "Link model type"
  @type t :: %__MODULE__{
          url: String.t(),
          description: String.t()
        }

  @type id :: integer | String.t()

  @typedoc "Link attributes types"
  @type attributes :: %{
          id: id,
          url: String.t(),
          description: String.t(),
          category_id: Category.id()
        }

  @allowed_attributes ~w[
    url
    description
    category_id
  ]a

  @required_attributes ~w[url]a

  @allowed_category_type "link"

  schema "links" do
    field(:url, :string)
    field(:description, :string)

    belongs_to(:category, Category)

    timestamps()
  end

  @spec changeset(%__MODULE__{}, attributes) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = link, attributes) do
    link
    |> cast(attributes, @allowed_attributes)
    |> validate_required(@required_attributes)
    |> validate_category(@allowed_category_type)
  end
end
