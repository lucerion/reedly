defmodule Reedly.API.Queries.LinkQueries do
  @moduledoc "Link queries"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.LinkResolver

  object :link_queries do
    @desc "All links"
    field :links, type: list_of(:link) do
      arg(:id, :integer)

      resolve(&LinkResolver.filter/3)
    end
  end
end
