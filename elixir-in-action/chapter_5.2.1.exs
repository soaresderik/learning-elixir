run_query = fn query ->
  Process.sleep(2000)
  "#{query} result"
end

async_query = fn query ->
  spawn(fn -> IO.puts(run_query.(query)) end)
end

# spawn(fn -> IO.puts(run_query.("query 2")) end)
# async_query.("query 1")

# A cada interação um processo é criado separadamente (independente e isolado), podendo ser executado simultaneamente (concurrently)
# Portando serão exibidos todos quase que imediatamente, no entando a ordem não é garantida.
Enum.each(1..100, &async_query.("query #{&1}"))
