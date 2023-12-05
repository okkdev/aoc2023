import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/result
import simplifile

pub type Cube {
  Red(n: Int)
  Green(n: Int)
  Blue(n: Int)
}

pub fn main() {
  let assert Ok(input) = simplifile.read("day2/input.txt")

  io.println("Part 1:")
  input
  |> parse_input()
  |> list.index_fold(
    0,
    fn(acc, g, i) {
      case
        list.all(
          g,
          fn(s) {
            case s {
              Red(n) if n <= 12 -> True
              Green(n) if n <= 13 -> True
              Blue(n) if n <= 14 -> True
              _otherwise -> False
            }
          },
        )
      {
        True -> acc + i + 1
        False -> acc
      }
    },
  )
  |> io.debug()

  io.println("Part 2:")
  input
  |> parse_input()
  |> list.fold(
    0,
    fn(acc, g) {
      let #(a, b, c) =
        list.fold(
          g,
          #(0, 0, 0),
          fn(acc, s) {
            case #(acc, s) {
              #(#(n, x, y), Red(m)) if m > n -> #(m, x, y)
              #(#(x, n, y), Green(m)) if m > n -> #(x, m, y)
              #(#(x, y, n), Blue(m)) if m > n -> #(x, y, m)
              _otherwise -> acc
            }
          },
        )

      acc + a * b * c
    },
  )
  |> io.debug()
}

fn parse_input(input) -> List(List(Cube)) {
  input
  |> string.trim()
  |> string.split("\n")
  |> list.map(fn(l) {
    let [_, v] = string.split(l, ":")

    string.split(v, ";")
    |> list.flat_map(fn(s) {
      string.split(s, ",")
      |> list.map(fn(x) {
        case
          string.trim(x)
          |> string.split(" ")
        {
          [n, "red"] ->
            int.parse(n)
            |> result.unwrap(0)
            |> Red
          [n, "green"] ->
            int.parse(n)
            |> result.unwrap(0)
            |> Green
          [n, "blue"] ->
            int.parse(n)
            |> result.unwrap(0)
            |> Blue
        }
      })
    })
  })
}
