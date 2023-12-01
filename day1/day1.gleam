import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/result
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

fn solve(input: String, matcher: fn(String) -> String) -> Int {
  input
  |> string.split("\n")
  |> list.map(fn(row) {
    let digits = find_digits(row, matcher)

    [string.first(digits), string.last(digits)]
    |> result.values()
    |> string.join("")
    |> int.parse()
    |> result.unwrap(0)
  })
  |> int.sum()
}

fn find_digits(row: String, matcher: fn(String) -> String) -> String {
  case row {
    "" -> ""
    r -> matcher(r) <> find_digits(string.drop_left(r, 1), matcher)
  }
}

fn part1_matcher(pattern: String) -> String {
  case pattern {
    "1" <> _ -> "1"
    "2" <> _ -> "2"
    "3" <> _ -> "3"
    "4" <> _ -> "4"
    "5" <> _ -> "5"
    "6" <> _ -> "6"
    "7" <> _ -> "7"
    "8" <> _ -> "8"
    "9" <> _ -> "9"
    _otherwise -> ""
  }
}

fn part2_matcher(pattern: String) -> String {
  case pattern {
    "1" <> _ | "one" <> _ -> "1"
    "2" <> _ | "two" <> _ -> "2"
    "3" <> _ | "three" <> _ -> "3"
    "4" <> _ | "four" <> _ -> "4"
    "5" <> _ | "five" <> _ -> "5"
    "6" <> _ | "six" <> _ -> "6"
    "7" <> _ | "seven" <> _ -> "7"
    "8" <> _ | "eight" <> _ -> "8"
    "9" <> _ | "nine" <> _ -> "9"
    _otherwise -> ""
  }
}
