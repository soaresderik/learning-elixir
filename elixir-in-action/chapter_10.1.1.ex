long_job = fn ->
  Process.sleep(2000)
  :some_result
end

task = Task.async(long_job)
Task.await(long_job)

run_query = fn query_def ->
  Process.sleep(2000)
  "#{query_def} result"
end

queries = 1..5

tasks =
  Enum.map(
    queries,
    &Task.async(fn -> run_query.("query #{&1}") end)
  )

Enum.map(tasks, &Task.await/1)

1..5
|> Enum.map(&Task.async(fn -> run_query.("query #{&1}") end))
|> Enum.map(&Task.await/1)

Task.start_link(fn ->
  Process.sleep(2000)
  IO.puts("Hello from task")
end)
