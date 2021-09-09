defmodule EchoServer do
  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, nil, name: via_tuple(id))
  end

  def call(id, some_request) do
    GenServer.call(via_tuple(id), some_request)
  end

  defp via_tuple(id) do
    {:via, Registry, {:my_registry, {__MODULE__, id}}}
  end

  def handle_call(some_request, _, state) do
    {:reply, some_request, state}
  end
end

# -- Executando --
Registry.start_link(name: :my_registry, keys: :unique)

EchoServer.start_link("server one")
EchoServer.start_link("server two")

EchoServer.call("server one", :some_request)
EchoServer.call("server two", :another_request)
