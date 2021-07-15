defmodule Pipelinez.Step do
  @callback call(token :: any) :: any
end
