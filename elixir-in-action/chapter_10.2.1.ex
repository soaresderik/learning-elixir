{:ok, pid} = Agent.start_link(fn -> %{name: "Bob", age: 30} end)

Agent.get(pid, fn state -> state.name end)
Agent.update(pid, fn state -> %{state | age: state.age + 1} end)
Agent.get(pid, fn state -> state end)
