defmodule Pipelinez.Demo.Pipeline do
  use Pipelinez.Demo.StepBuilder

  step Pipelinez.Demo.One
  step Pipelinez.Demo.Two
  step Pipelinez.Demo.Three
end
