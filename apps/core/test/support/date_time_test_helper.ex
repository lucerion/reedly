defmodule Reedly.Core.Test.DateTimeTestHelper do
  @moduledoc "DateTime tests helper functions"

  @default_date_time_format "%a, %d %b %Y %H:%M:%S %z"

  def format_date_time(date_time, format \\ @default_date_time_format) do
    case Timex.format(date_time, format, :strftime) do
      {:ok, date_time_string} -> date_time_string
      _ -> nil
    end
  end

  def random_naive_date_time,
    do: random_naive_date_time(years_offset: 1)

  def random_naive_date_time(years_offset: years_offset) do
    years_offset
    |> random_date_time()
    |> DateTime.to_naive()
  end

  def random_naive_date_time(truncate: precision),
    do: random_naive_date_time(years_offset: 1, truncate: precision)

  def random_naive_date_time(years_offset: years_offset, truncate: precision) do
    random_naive_date_time(years_offset: years_offset)
    |> NaiveDateTime.truncate(precision)
  end

  defp random_date_time(years_offset \\ 1) do
    from_date = Timex.now()
    to_date = Timex.shift(from_date, years: years_offset)

    Faker.DateTime.between(from_date, to_date)
  end
end
