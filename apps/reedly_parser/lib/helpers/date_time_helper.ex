defmodule Reedly.Parser.Helpers.DateTimeHelper do
  @moduledoc "Helper functions for working with dates"

  @default_format "%a, %d %b %Y %H:%M:%S %z"

  @spec parse(String.t(), String.t()) :: NaiveDateTime.t() | nil
  def parse(date_time_string, format \\ @default_format) do
    case Timex.parse(date_time_string, format, :strftime) do
      {:ok, date_time} -> DateTime.to_naive(date_time)
      _ -> nil
    end
  end
end
