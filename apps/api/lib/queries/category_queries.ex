defmodule Reedly.API.Queries.CategoryQueries do
  @moduledoc "Category queries"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.CategoryResolver

  object :category_queries do
    @desc "Categories"
    field :categories, type: list_of(:category) do
      arg(:type, :string)

      resolve(&CategoryResolver.filter/3)
    end
  end
end
