defmodule Pipelinez.Demo.Token do
  @enforce_keys [:zero]
  defstruct [
    :zero,
    :one,
    :two,
    :three,
    :halted
  ]

  alias __MODULE__

  def build() do
    %Token{zero: 0}
  end
end
