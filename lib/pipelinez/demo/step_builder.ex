defmodule Pipelinez.Demo.StepBuilder do
  defmacro __before_compile__(env) do
    steps = Module.get_attribute(env.module, :steps)
    body = Pipelinez.Demo.StepBuilder.compile_body(steps)

    quote do
      defp __do_call__(token) do
        unquote(body)
      end
    end
  end

  defmacro __using__(_opts \\ []) do
    quote do
      import Pipelinez.Demo.StepBuilder

      Module.register_attribute(__MODULE__, :steps, accumulate: true)

      @before_compile Pipelinez.Demo.StepBuilder

      def call(token) do
        __do_call__(token)
      end
    end
  end

  defmacro step(module) do
    quote do
      @steps unquote(module)
    end
  end

  def compile_body(steps) do
    initial_statement = quote do: token

    Enum.reduce(steps, initial_statement, &compile_step/2)
  end

  def compile_step(step, already_compiled_statements) do
    current_call = quote do: unquote(step).call(token)

    quote do
      case unquote(current_call) do
        %Pipelinez.Demo.Token{halted: true} = token ->
          token

        %Pipelinez.Demo.Token{} = token ->
          unquote(already_compiled_statements)

        _ ->
          raise unquote("expected #{step}.call/1 to return a Token")
      end
    end
  end
end
