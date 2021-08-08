run_query = fn query ->
  Process.sleep(2000)
  IO.puts("#{query} result")
end

run_query.("query 1")
Enum.map(1..5, &run_query.("query #{&1}"))
