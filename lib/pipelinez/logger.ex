defmodule Pipelinez.Logger do
  require Logger

  def log(step, token) do
    Logger.warn("step: (#{inspect(step)}) token: (#{inspect(token)})")
  end
end
