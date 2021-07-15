defmodule PipelinezWeb.DemoTest do
  use ExUnit.Case, async: true


  test "example demo sums" do
    %Pipelinez.Demo.Token{three: three} =
      Pipelinez.Demo.Token.build()
      |> Pipelinez.Demo.Pipeline.call()

    assert three == 6
  end
end
