defmodule Reedly.Core.Helpers.HTTPHelper do
  @moduledoc "HTTP helper functions"

  @doc "Gets resource by url"
  @spec get(String.t()) :: {:ok, String.t()} | {:error, HTTPoison.Error.t()}
  def get(url) do
    case HTTPoison.get(url, [], follow_redirect: true) do
      {:ok, %HTTPoison.Response{body: body}} -> {:ok, body}
      error -> error
    end
  end
end
