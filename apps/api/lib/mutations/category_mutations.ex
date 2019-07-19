defmodule Reedly.API.Mutations.CategoryMutations do
  @moduledoc "Category mutations"

  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias Reedly.API.Resolvers.CategoryResolver

  payload_object(:category_result, :category)

  object :category_mutations do
    @desc "Create a category"
    field :create_category, type: :category_result do
      arg(:name, non_null(:string))
      arg(:type, non_null(:string))

      resolve(&CategoryResolver.create/3)
      middleware(&build_payload/2)
    end

    @desc "Update a category"
    field :update_category, type: :category_result do
      arg(:id, non_null(:integer))
      arg(:name, non_null(:string))

      resolve(&CategoryResolver.update/3)
      middleware(&build_payload/2)
    end

    @desc "Delete a category"
    field :delete_category, type: :category_result do
      arg(:id, non_null(:integer))

      resolve(&CategoryResolver.delete/3)
      middleware(&build_payload/2)
    end
  end
end
