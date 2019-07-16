defmodule Reedly.Core.Test.DateTimeTestHelper do
  @moduledoc "DateTime tests helper functions"

  @default_date_time_format "%a, %d %b %Y %H:%M:%S %z"

  def format_date_time(date_time, format \\ @default_date_time_format) do
    case Timex.format(date_time, format, :strftime) do
      {:ok, date_time_string} -> date_time_string
      _ -> nil
    end
  end
end
