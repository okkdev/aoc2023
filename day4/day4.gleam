import gleam/list
import gleam/io
import gleam/int
import gleam/string
import gleam/result
import simplifile

pub fn main() {
  let assert Ok(input) = simplifile.read("day4/input.txt")

  input
  |> string.trim()
  |> string.split("\n")
  |> list.map(fn(x) {
    let [_, xs] = string.split(x, ":")

    string.split(xs, "|")
    |> list.map(fn(n) {
      string.split(n, " ")
      |> list.filter_map(int.parse)
    })
  })
  |> list.map(fn(c) {
    let [w, m] = c

    list.fold(
      m,
      0,
      fn(acc, n) {
        case list.contains(w, n) {
          True ->
            case acc {
              0 -> 1
              _ -> acc * 2
            }
          False -> acc
        }
      },
    )
  })
  |> int.sum()
  |> io.debug()
}
