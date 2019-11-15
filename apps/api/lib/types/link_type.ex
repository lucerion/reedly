defmodule Reedly.API.Types.LinkType do
  @moduledoc "Link type"

  use Absinthe.Schema.Notation

  @desc "Link type"
  object :link do
    field(:id, :integer)
    field(:url, :string)
    field(:description, :string)
    field(:category, :category)
  end

  @desc "Link result type"
  object :link_result do
    field(:result, :link)
    field(:errors, list_of(:error))
  end
end
