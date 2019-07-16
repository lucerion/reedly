defmodule Reedly.API.Types.CategoryType do
  @moduledoc "Category type"

  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias Reedly.API.Resolvers.CategoryResolver

  @desc "Category type"
  object :category do
    field(:id, :integer)
    field(:name, :string)
    field(:type, :string)
  end

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
