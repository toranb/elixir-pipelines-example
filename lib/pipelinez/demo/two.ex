defmodule Pipelinez.Demo.Two do
  @behaviour Pipelinez.Demo.Step

  alias Pipelinez.Demo.Token

  def call(%Token{one: one} = token) do
    %Token{token | two: one + 2}
  end
end
