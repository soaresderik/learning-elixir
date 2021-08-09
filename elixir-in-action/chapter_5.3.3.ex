defmodule Calculator do
  def start do
    spawn(fn -> loop(0) end)
  end

  def value(server_pid) do
    send(server_pid, {:value, self()})

    receive do
      {:response, value} ->
        value
    end
  end

  def add(server_pid, value), do: send(server_pid, {:add, value})
  def sub(server_pid, value), do: send(server_pid, {:sub, value})
  def mul(server_pid, value), do: send(server_pid, {:mul, value})
  def div(server_pid, value), do: send(server_pid, {:div, value})

  defp loop(current_state) do
    new_state =
      receive do
        {:value, caller} ->
          send(caller, {:response, current_state})
          current_state

        {:add, value} ->
          current_state + value

        {:sub, value} ->
          current_state - value

        {:mul, value} ->
          current_state * value

        {:div, value} ->
          current_state / value

        default ->
          IO.puts("Invalid request: #{inspect(default)}")
          current_state
      end

    loop(new_state)
  end
end

# -- Executando --

# calculator_pid = Calculator.start()

# Calculator.add(calculator_pid, 10)
# Calculator.sub(calculator_pid, 5)
# Calculator.mul(calculator_pid, 3)
# Calculator.div(calculator_pid, 5)
# Calculator.value(calculator_pid)
