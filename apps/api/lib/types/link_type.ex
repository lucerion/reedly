defmodule Reedly.API.Types.LinkType do
  @moduledoc "Link type"

  use Absinthe.Schema.Notation

  @desc "Link type"
  object :link do
    field(:id, :integer)
    field(:url, :string)
    field(:description, :string)
  end
end
