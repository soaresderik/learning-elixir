defmodule DatabaseServer do
  # -- Funções de Clientes --
  def start do
    spawn(&loop/0)
  end

  def run_async(server_pid, query) do
    send(server_pid, {:run_query, self(), query})
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    after
      5000 -> {:error, :timeout}
    end
  end

  # -- Funções de Servidor --

  # Este loop não é desgastante para a CPU.
  # Esperar por uma mensagem coloca o processo em um estado suspenso e não desperdiça clock de CPU.
  defp loop do
    receive do
      {:run_query, caller, query} ->
        send(caller, {:query_result, run_query(query)})
    end

    loop()
  end

  defp run_query(query) do
    Process.sleep(2000)
    "#{query} result"
  end
end

# ---- Executando ----

# -- executando sequencialmente --
# server_pid = DatabaseServer.start()
# DatabaseServer.run_async(server_pid, "query 1")
# DatabaseServer.get_result()

# -- executando em paralelo --
# Você pode pensar que 100 processos é muito, mas lembre-se de que os processos são leves. Eles ocupam uma pequena quantidade de memória (~ 2 KB) e são criados muito rapidamente (em alguns microssegundos). Além disso, como todos esses processos esperam por uma mensagem, eles ficam efetivamente ociosos e não perdem tempo de CPU.
# pool = Enum.map(1..100, fn _ -> DatabaseServer.start() end)
#
# Enum.each(1..5, fn query ->
#   server_pid = Enum.at(pool, :rand.uniform(100) - 1)
#   DatabaseServer.run_async(server_pid, query)
# end)

# Enum.map(1..5, fn _ -> DatabaseServer.get_result() end)
