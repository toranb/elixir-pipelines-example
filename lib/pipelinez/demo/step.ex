defmodule Pipelinez.Demo.Step do
  @callback call(token :: Pipelinez.Demo.Token.t()) :: Pipelinez.Demo.Token.t()
end
