defmodule Reedly.API.Mutations.CategoryMutations do
  @moduledoc "Category mutations"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.CategoryResolver

  object :category_mutations do
    @desc "Creates a category"
    field :create_category, type: :category_result do
      arg(:name, non_null(:string))
      arg(:type, non_null(:string))

      resolve(&CategoryResolver.create/3)
    end

    @desc "Updates a category"
    field :update_category, type: :category_result do
      arg(:id, non_null(:integer))
      arg(:name, non_null(:string))

      resolve(&CategoryResolver.update/3)
    end

    @desc "Deletes a category"
    field :delete_category, type: :category_result do
      arg(:id, non_null(:integer))

      resolve(&CategoryResolver.delete/3)
    end
  end
end
