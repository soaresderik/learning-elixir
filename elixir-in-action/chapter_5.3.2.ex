defmodule DatabaseServer do
  def start do
    spawn(fn ->
      conn = :rand.uniform(1000)
      loop(conn)
    end)
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

  defp loop(conn) do
    receive do
      {:run_query, from_pid, query} ->
        query_result = run_query(conn, query)
        send(from_pid, {:query_result, query_result})
    end

    loop(conn)
  end

  defp run_query(conn, query) do
    Process.sleep(2000)
    "Connection #{conn}: #{query} result"
  end
end

# -- Executando --

# server_pid = DatabaseServer.start()
# DatabaseServer.run_async(server_pid, "query 1")
# DatabaseServer.get_result()

# DatabaseServer.run_async(server_pid, "query 2")
# DatabaseServer.get_result()
