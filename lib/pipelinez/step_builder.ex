defmodule Pipelinez.StepBuilder do
  defmacro __before_compile__(env) do
    steps = Module.get_attribute(env.module, :steps)
    body = __MODULE__.compile_body(steps)

    quote do
      defp __do_call__(token) do
        unquote(body)
      end
    end
  end

  defmacro __using__(opts) do
    log_token = opts[:log]
    token_module = opts[:token]

    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :steps, accumulate: true)

      @before_compile unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :token, persist: true)
      @token unquote(token_module)

      Module.register_attribute(__MODULE__, :log, persist: true)
      @log unquote(log_token)

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
    log_token = quote do: @log
    token_module = quote do: @token
    current_call = quote do: unquote(step).call(token)

    quote do
      case unquote(current_call) do
        %unquote(token_module){halted: true} = token ->
          if unquote(log_token) == true do
            logger_module = Module.concat(["Pipelinez.Logger"])
            logger_module.log(unquote(step), token)
          end

          token

        %unquote(token_module){} = token ->
          if unquote(log_token) == true do
            logger_module = Module.concat(["Pipelinez.Logger"])
            logger_module.log(unquote(step), token)
          end

          unquote(already_compiled_statements)

        _ ->
          raise unquote("expected #{step}.call/1 to return a Token")
      end
    end
  end
end
