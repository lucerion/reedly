defmodule Reedly.Core.Fetcher do
  @moduledoc "Fetches feed xml"

  @doc "Fetch feed xml by url"
  @spec fetch(String.t()) :: {:ok, String.t()} | {:error, HTTPoison.Error.t()}
  def fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} -> {:ok, body}
      error -> error
    end
  end
end
