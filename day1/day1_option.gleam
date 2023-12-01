import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/result
import gleam/option.{type Option, None, Some}
import simplifile

pub fn main() {
  let assert Ok(input) = simplifile.read("day1/input.txt")

  io.println("Part 1:")
  solve(input, part1_matcher)
  |> io.debug()

  io.println("Part 2:")
  solve(input, part2_matcher)
  |> io.debug()
}

fn solve(input: String, matcher: fn(String) -> Option(Int)) -> Int {
  input
  |> string.split("\n")
  |> list.map(fn(row) {
    let digits =
      find_digits(row, matcher)
      |> option.values()

    [list.first(digits), list.last(digits)]
    |> result.values()
    |> int.undigits(10)
    |> result.unwrap(0)
  })
  |> int.sum()
}

fn find_digits(
  row: String,
  matcher: fn(String) -> Option(Int),
) -> List(Option(Int)) {
  case row {
    "" -> []
    r -> [matcher(r), ..find_digits(string.drop_left(r, 1), matcher)]
  }
}

fn part1_matcher(pattern: String) -> Option(Int) {
  case pattern {
    "1" <> _ -> Some(1)
    "2" <> _ -> Some(2)
    "3" <> _ -> Some(3)
    "4" <> _ -> Some(4)
    "5" <> _ -> Some(5)
    "6" <> _ -> Some(6)
    "7" <> _ -> Some(7)
    "8" <> _ -> Some(8)
    "9" <> _ -> Some(9)
    _otherwise -> None
  }
}

fn part2_matcher(pattern: String) -> Option(Int) {
  case pattern {
    "1" <> _ | "one" <> _ -> Some(1)
    "2" <> _ | "two" <> _ -> Some(2)
    "3" <> _ | "three" <> _ -> Some(3)
    "4" <> _ | "four" <> _ -> Some(4)
    "5" <> _ | "five" <> _ -> Some(5)
    "6" <> _ | "six" <> _ -> Some(6)
    "7" <> _ | "seven" <> _ -> Some(7)
    "8" <> _ | "eight" <> _ -> Some(8)
    "9" <> _ | "nine" <> _ -> Some(9)
    _otherwise -> None
  }
}
