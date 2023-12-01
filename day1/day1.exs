defmodule Day1 do
  @nums %{
    "1" => "one",
    "2" => "two",
    "3" => "three",
    "4" => "four",
    "5" => "five",
    "6" => "six",
    "7" => "seven",
    "8" => "eight",
    "9" => "nine"
  }

  def solve(input) do
    input
    |> Enum.map(fn cor ->
      cor
      |> String.graphemes()
      |> Enum.filter(
        &case Integer.parse(&1) do
          :error -> false
          _ -> true
        end
      )
      |> then(&(hd(&1) <> hd(Enum.reverse(&1))))
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  def part1(input) do
    solve(input)
  end

  def part2(input) do
    input
    |> Enum.map(fn z ->
      Enum.reduce(String.graphemes(z), "", fn x, ac ->
        Enum.reduce_while(@nums, ac <> x, fn {n, p}, acc ->
          r = String.replace(acc, p, n, global: false)

          case r != acc do
            true -> {:halt, r <> x}
            false -> {:cont, acc}
          end
        end)
      end)
    end)
    |> solve()
  end
end

input =
  "input.txt"
  |> File.read!()
  |> String.split("\n")

Day1.part1(input)
|> IO.inspect(label: "Part 1")

Day1.part2(input)
|> IO.inspect(label: "Part 2")
