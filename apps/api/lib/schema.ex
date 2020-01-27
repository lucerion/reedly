defmodule Reedly.API.Schema do
  @moduledoc "API GraphQL schema"

  use Absinthe.Schema

  alias Reedly.API.Types.{ErrorType, CategoryType, LinkType, FeedEntryType, FeedType}
  alias Reedly.API.Queries.{LinkQueries, FeedQueries, FeedEntryQueries}
  alias Reedly.API.Mutations.{CategoryMutations, LinkMutations, FeedMutations, FeedEntryMutations}
  alias Reedly.API.Middlewares.ErrorMiddleware

  import_types(Absinthe.Type.Custom)
  import_types(ErrorType)
  import_types(CategoryType)
  import_types(LinkType)
  import_types(FeedEntryType)
  import_types(FeedType)

  import_types(LinkQueries)
  import_types(FeedQueries)
  import_types(FeedEntryQueries)

  import_types(CategoryMutations)
  import_types(LinkMutations)
  import_types(FeedMutations)
  import_types(FeedEntryMutations)

  def middleware(middlewares, _field, %{identifier: :mutation}), do: middlewares ++ [ErrorMiddleware]
  def middleware(middlewares, _field, _object), do: middlewares

  query do
    import_fields(:link_queries)
    import_fields(:feed_queries)
    import_fields(:feed_entry_queries)
  end

  mutation do
    import_fields(:category_mutations)
    import_fields(:link_mutations)
    import_fields(:feed_mutations)
    import_fields(:feed_entry_mutations)
  end
end
