defmodule Reedly.Core.Test.DateTimeHelperTest do
  use ExUnit.Case

  alias Reedly.Core.Helpers.DateTimeHelper

  describe "parse/1" do
    test "returns a parsed date time" do
      assert DateTimeHelper.parse("Mon, 10 Jan 2011 12:13:14 +0000") == ~N[2011-01-10 12:13:14]
    end

    test "returns nil when timestamp is not valid" do
      assert DateTimeHelper.parse("Mon 10 Jan 2011 12:13:14 +0000") == nil
    end

    test "returns nil when timestamp is nil" do
      assert DateTimeHelper.parse(nil) == nil
    end
  end
end
