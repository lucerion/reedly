defmodule Reedly.API.Queries.LinkQueries do
  @moduledoc "Link queries"

  use Absinthe.Schema.Notation

  alias Reedly.API.Resolvers.LinkResolver

  object :link_queries do
    @desc "Links"
    field :links, type: list_of(:link) do
      arg(:category_id, :integer)

      resolve(&LinkResolver.fetch/3)
    end
  end
end
