defmodule Reedly.API.Types.CategoryType do
  @moduledoc "Category type"

  use Absinthe.Schema.Notation

  @desc "Category type"
  object :category do
    field(:id, :integer)
    field(:name, :string)
    field(:type, :string)
  end

  @desc "Category result type"
  object :category_result do
    field(:result, :category)
    field(:errors, list_of(:error))
  end
end
