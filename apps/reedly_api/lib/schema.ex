defmodule Reedly.API.Schema do
  @moduledoc "API GraphQL schema"

  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(Kronky.ValidationMessageTypes)
  import_types(Reedly.API.Types.FeedType)
  import_types(Reedly.API.Types.FeedEntryType)

  query do
    import_fields(:feed_entry_queries)
  end

  mutation do
    import_fields(:feed_mutations)
  end
end
