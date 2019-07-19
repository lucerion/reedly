defmodule Reedly.API.Middlewares.ErrorMiddleware do
  @moduledoc "Middleware to handle errors"

  @behaviour Absinthe.Middleware

  def call(%{value: value, errors: errors} = resolution, _),
    do: %{resolution | value: %{result: value, errors: format_errors(errors)}, errors: []}

  defp format_errors([]), do: []
  defp format_errors([%Ecto.Changeset{errors: errors}]), do: Enum.map(errors, &format_error(&1))

  defp format_error({field, {message, _}}), do: %{key: to_string(field), message: message}
end
