defmodule Reedly.Core.Test.DateTimeHelperTest do
  use ExUnit.Case

  alias Reedly.Core.Helpers.DateTimeHelper

  describe "parse/1" do
    test "returns a parsed date time when date time string is valid" do
      assert DateTimeHelper.parse("Mon, 10 Jan 2011 12:13:14 +0000") == ~N[2011-01-10 12:13:14]
    end

    test "returns nil when date time string is not valid" do
      assert DateTimeHelper.parse("2011-01-10 12:13:14") == nil
    end
  end
end
