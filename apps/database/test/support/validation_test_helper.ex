defmodule Reedly.Database.Test.ValidationTestHelper do
  @moduledoc "Validation tests helper functions"

  @doc "Checks failed validation type for field"
  def validation_error?({:error, %{errors: errors}}, attribute, error_type),
    do: Enum.any?(errors, &(invalid_attribute?(&1, attribute) && error_type?(&1, error_type)))

  defp invalid_attribute?({error_attribute, _}, attribute), do: error_attribute == attribute

  defp error_type?({_attribute, {_message, [validation: error_type]}}, type), do: error_type == type
  defp error_type?({_attribute, {_message, [constraint: error_type, constraint_name: _]}}, type), do: error_type == type
end
