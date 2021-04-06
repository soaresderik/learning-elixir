defmodule NumberCompare do
  def greater(number, other) do
    check(number >=other, number, other)
  end

  defp check(true, number, _), do: number
  defp check(false, _, other), do: other
end
