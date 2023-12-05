import gleam/list
import gleam/io
import gleam/int
import gleam/float
import gleam/string
import gleam/result
import simplifile

pub fn main() {
  let assert Ok(raw_input) = simplifile.read("day4/input.txt")
  let input = parse_input(raw_input)
  let wins = count_wins(input)

  io.println("Part 1:")
  wins
  |> list.fold(
    0,
    fn(acc, x) {
      int.power(x - 1, 2.0)
      |> result.unwrap(0.0)
      |> float.round()
      |> int.add(acc)
    },
  )
  |> io.debug()

  io.println("Part 2:")
  let i_wins = list.index_map(wins, fn(i, x) { #(i + 1, x) })
  jackpot(i_wins, i_wins)
  |> io.debug()
}

fn parse_input(input: String) -> List(List(List(Int))) {
  string.trim(input)
  |> string.split("\n")
  |> list.map(fn(x) {
    let [_, xs] = string.split(x, ":")

    string.split(xs, "|")
    |> list.map(fn(n) {
      string.split(n, " ")
      |> list.filter_map(int.parse)
    })
  })
}

fn count_wins(input: List(List(List(Int)))) -> List(Int) {
  list.map(
    input,
    fn(c) {
      let [w, m] = c
      list.fold(
        m,
        0,
        fn(acc, n) {
          case list.contains(w, n) {
            True -> acc + 1
            False -> acc
          }
        },
      )
    },
  )
}

fn jackpot(wins, all_wins) {
  case wins {
    [] -> list.length(all_wins)
    [#(i, w), ..rest] ->
      w + jackpot(
        list.drop(all_wins, i)
        |> list.take(w)
        |> list.append(rest),
        all_wins,
      )
  }
}
