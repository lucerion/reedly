defmodule Reedly.API.Types.ErrorType do
  @moduledoc "Error type"

  use Absinthe.Schema.Notation

  @desc "Error type"
  object :error do
    field(:key, :string)
    field(:message, :string)
  end
end
