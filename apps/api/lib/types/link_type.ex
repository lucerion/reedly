defmodule Reedly.API.Types.LinkType do
  @moduledoc "Link type"

  use Absinthe.Schema.Notation

  import Kronky.Payload

  alias Reedly.API.Resolvers.LinkResolver

  @desc "Link type"
  object :link do
    field(:id, :integer)
    field(:url, :string)
    field(:description, :string)
  end

  object :link_queries do
    @desc "All links"
    field :links, type: list_of(:link) do
      resolve(&LinkResolver.all/3)
    end
  end

  payload_object(:link_result, :link)

  object :link_mutations do
    @desc "Create a link"
    field :create_link, type: :link_result do
      arg(:url, non_null(:string))
      arg(:description, :string)

      resolve(&LinkResolver.create/3)
      middleware(&build_payload/2)
    end

    @desc "Update a link"
    field :update_link, type: :link_result do
      arg(:id, non_null(:integer))
      arg(:url, non_null(:string))

      resolve(&LinkResolver.update/3)
      middleware(&build_payload/2)
    end

    @desc "Delete a link"
    field :delete_link, type: :link_result do
      arg(:id, non_null(:integer))

      resolve(&LinkResolver.delete/3)
      middleware(&build_payload/2)
    end
  end
end
