defmodule Pipelinez.Demo.Three do
  @behaviour Pipelinez.Step

  alias Pipelinez.Demo.Token

  def call(%Token{two: two} = token) do
    %Token{token | three: two + 3}
  end
end
