defmodule Reedly.Database.Test.TestFactory do
  @moduledoc "Test factories interface"

  @callback build_attributes() :: map
  @callback create(map) :: struct

  defmacro __using__(_opts) do
    quote do
      @behaviour Reedly.Database.Test.TestFactory

      def build_attributes(attributes) when is_map(attributes),
        do: Map.merge(build_attributes(), attributes)

      def build_attributes(count: count) when count <= 0,
        do: build_attributes()

      def build_attributes(count: count),
        do: Enum.map(0..(count - 1), fn _x -> build_attributes() end)

      def create, do: create(%{})

      def create(count: count) when count <= 0,
        do: create()

      def create(count: count),
        do: Enum.map(0..(count - 1), fn _x -> create() end)

      def create(attributes, count: count) when count <= 0,
        do: create(attributes)

      def create(attributes, count: count),
        do: Enum.map(0..(count - 1), fn _x -> create(attributes) end)

      def extract_result({:ok, entity}), do: entity
      def extract_result({:error, changeset}), do: changeset
    end
  end
end
