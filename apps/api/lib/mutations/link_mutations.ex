defmodule Reedly.API.Mutations.LinkMutations do
  @moduledoc "Link mutations"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.LinkResolver

  object :link_mutations do
    @desc "Create a link"
    field :create_link, type: :link_result do
      arg(:url, non_null(:string))
      arg(:description, :string)

      resolve(&LinkResolver.create/3)
    end

    @desc "Update a link"
    field :update_link, type: :link_result do
      arg(:id, non_null(:integer))
      arg(:url, non_null(:string))

      resolve(&LinkResolver.update/3)
    end

    @desc "Delete a link"
    field :delete_link, type: :link_result do
      arg(:id, non_null(:integer))

      resolve(&LinkResolver.delete/3)
    end
  end
end
