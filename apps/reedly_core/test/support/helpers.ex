defmodule Reedly.Core.Test.Helpers do
  @moduledoc "Tests helper functions"

  @default_date_time_format "%a, %d %b %Y %H:%M:%S %z"

  @doc "Checks failed validation type for field"
  def validation_error?({:error, %{errors: errors}}, attribute, error_type),
    do: Enum.any?(errors, &(invalid_attribute?(&1, attribute) && error_type?(&1, error_type)))

  defp invalid_attribute?({error_attribute, _}, attribute), do: error_attribute == attribute

  defp error_type?({_attribute, {_message, [validation: error_type]}}, type), do: error_type == type
  defp error_type?({_attribute, {_message, [constraint: error_type, constraint_name: _]}}, type), do: error_type == type

  def format_date_time(date_time, format \\ @default_date_time_format) do
    case Timex.format(date_time, format, :strftime) do
      {:ok, date_time_string} -> date_time_string
      _ -> nil
    end
  end
end
