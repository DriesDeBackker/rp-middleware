defmodule RpMiddlewareTest do
  use ExUnit.Case
  doctest RpMiddleware

  test "greets the world" do
    assert RpMiddleware.hello() == :world
  end
end
