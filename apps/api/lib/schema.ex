defmodule Reedly.API.Schema do
  @moduledoc "API GraphQL schema"

  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(Kronky.ValidationMessageTypes)

  import_types(Reedly.API.Types.CategoryType)
  import_types(Reedly.API.Types.LinkType)
  import_types(Reedly.API.Types.FeedType)
  import_types(Reedly.API.Types.FeedEntryType)

  import_types(Reedly.API.Queries.LinkQueries)
  import_types(Reedly.API.Queries.FeedEntryQueries)

  import_types(Reedly.API.Mutations.CategoryMutations)
  import_types(Reedly.API.Mutations.LinkMutations)
  import_types(Reedly.API.Mutations.FeedMutations)
  import_types(Reedly.API.Mutations.FeedEntryMutations)

  query do
    import_fields(:link_queries)
    import_fields(:feed_entry_queries)
  end

  mutation do
    import_fields(:category_mutations)
    import_fields(:link_mutations)
    import_fields(:feed_mutations)
    import_fields(:feed_entry_mutations)
  end
end
