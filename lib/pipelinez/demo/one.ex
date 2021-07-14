defmodule Pipelinez.Demo.One do
  @behaviour Pipelinez.Demo.Step

  alias Pipelinez.Demo.Token

  def call(%Token{zero: zero} = token) do
    %Token{token | one: zero + 1}
  end
end
