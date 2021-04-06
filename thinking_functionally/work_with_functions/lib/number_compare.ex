defmodule NumberCompare do
  def greater(number, other) when number >= other, do: number
  def greater(_, other), do: other
end
