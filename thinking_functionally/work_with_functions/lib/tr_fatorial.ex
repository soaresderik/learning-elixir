defmodule TRFatorial do
  def of(n), do: fatorial_of(n, 1)
  defp fatorial_of(0, acc), do: acc
  defp fatorial_of(n, acc) when n > 0, do: fatorial_of(n - 1, n * acc)
end
