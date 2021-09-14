{:ok, counter} = Agent.start_link(fn -> 0 end)

spawn(fn -> Agent.update(counter, fn count -> count + 1 end) end)

Agent.get(counter, fn count -> count end)
