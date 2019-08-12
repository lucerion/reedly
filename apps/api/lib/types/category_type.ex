defmodule Reedly.API.Types.CategoryType do
  @moduledoc "Category type"

  use Absinthe.Schema.Notation

  @desc "Category type"
  object :category do
    field(:id, :integer)
    field(:name, :string)
    field(:type, :string)
    field(:feeds, list_of(:feed))
  end

  @desc "Category result type"
  object :category_result do
    field(:result, :category)
    field(:errors, list_of(:error))
  end
end
