defmodule Reedly.Core.Helpers.DateTimeHelper do
  @moduledoc """
  Dates helper functions

  Timestamp formats

  * `{RFC822}`   - `Mon, 05 Jun 14 23:20:59 UT`
  * `{RFC822z}`  - `Mon, 05 Jun 14 23:20:59 Z`
  * `{RFC1123}`  - `Tue, 05 Mar 2013 23:25:19 +0200`
  * `{RFC1123z}` - `Tue, 05 Mar 2013 23:25:19 Z`
  * `{RFC3339}`  - `2013-03-05T23:25:19+02:00`
  * `{RFC3339z}` - `2013-03-05T23:25:19Z`
  * `{ANSIC}`    - `Tue Mar 5 23:25:19 2013`
  * `{UNIX}`     - `Tue Mar 5 23:25:19 PST 2013`
  """

  @timestamp_formats ~w[
    {RFC822}
    {RFC822z}
    {RFC1123}
    {RFC1123z}
    {RFC3339}
    {RFC3339z}
    {ANSIC}
    {UNIX}
  ]

  @spec parse(String.t() | nil, list(String.t()) | String.t()) :: NaiveDateTime.t() | nil
  def parse(nil), do: nil
  def parse(timestamp), do: parse(timestamp, @timestamp_formats)
  def parse(_timestamp, []), do: nil

  def parse(timestamp, [format | formats]) do
    case Timex.parse(timestamp, format) do
      {:ok, date_time} -> DateTime.to_naive(date_time)
      _ -> parse(timestamp, formats)
    end
  end
end
