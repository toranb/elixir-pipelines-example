defmodule Mix.Tasks.Demo do
  use Mix.Task

  @moduledoc false

  @doc false
  def run(_args) do
    Application.ensure_all_started(:pipelinez)

    %Pipelinez.Demo.Token{three: three} =
      Pipelinez.Demo.Token.build()
      |> Pipelinez.Demo.Pipeline.call()

    three |> IO.inspect(label: "Pipeline sum")

    :ok
  end
end
