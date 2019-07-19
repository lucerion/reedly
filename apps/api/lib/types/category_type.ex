defmodule Reedly.API.Types.CategoryType do
  @moduledoc "Category type"

  use Absinthe.Schema.Notation

  @desc "Category type"
  object :category do
    field(:id, :integer)
    field(:name, :string)
    field(:type, :string)
  end
end
