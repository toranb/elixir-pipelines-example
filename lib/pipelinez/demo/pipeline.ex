defmodule Pipelinez.Demo.Pipeline do
  use Pipelinez.StepBuilder, token: Pipelinez.Demo.Token, log: false

  step Pipelinez.Demo.One
  step Pipelinez.Demo.Two
  step Pipelinez.Demo.Three
end
