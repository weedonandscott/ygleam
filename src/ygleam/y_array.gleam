import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/int
import gleam/list
import gleam/option.{type Option}
import gleam/order
import ygleam/y
import ygleam/y_event.{type AnyYEvent, type YArrayEvent}

pub type YArrayError {
  YArrayError
  LengthExceeded
}

@external(javascript, "../yArray.mjs", "decode")
fn do_decode(data: Dynamic) -> Result(y.Array, y.Array)

pub fn decoder() -> decode.Decoder(y.Array) {
  decode.new_primitive_decoder("y.Array", do_decode)
}

@external(javascript, "../yArray.mjs", "do_new")
pub fn new() -> y.Array

@external(javascript, "../yArray.mjs", "doc")
pub fn doc(y_array: y.Array) -> Option(y.Doc)

@external(javascript, "../yArray.mjs", "parent")
pub fn parent(y_array: y.Array) -> Option(Dynamic)

@external(javascript, "../yArray.mjs", "from")
pub fn from(items: List(y.Value)) -> y.Array

@external(javascript, "../yArray.mjs", "length")
pub fn length(y_array: y.Array) -> Int

@external(javascript, "../yArray.mjs", "insert")
pub fn insert(
  y_array: y.Array,
  index: Int,
  items: List(y.Value),
) -> Result(y.Array, YArrayError)

@external(javascript, "../yArray.mjs", "delete_from_index")
pub fn delete(
  y_array: y.Array,
  index: Int,
  length: Int,
) -> Result(y.Array, YArrayError)

pub fn delete_where(y_array: y.Array, predicate: fn(Dynamic) -> Bool) -> y.Array {
  y_array
  |> map(fn(value, index, _) {
    case predicate(value) {
      True -> Ok(index)
      False -> Error(Nil)
    }
  })
  |> list.filter_map(fn(x) { x })
  |> list.sort(order.reverse(int.compare))
  |> list.each(fn(index) {
    y_array
    |> delete(index, 1)
  })

  y_array
}

@external(javascript, "../yArray.mjs", "push")
pub fn push(y_array: y.Array, items: List(y.Value)) -> y.Array

@external(javascript, "../yArray.mjs", "unshift")
pub fn unshift(y_array: y.Array, items: List(y.Value)) -> y.Array

pub fn index_of(
  y_array: y.Array,
  predicate: fn(Dynamic) -> Bool,
) -> Result(Int, Nil) {
  index_of_loop(y_array, predicate, 0)
}

fn index_of_loop(
  y_array: y.Array,
  predicate: fn(Dynamic) -> Bool,
  index: Int,
) -> Result(Int, Nil) {
  case
    y_array
    |> get(index)
    |> predicate
  {
    True -> Ok(index)
    False ->
      case
        index
        == {
          y_array
          |> length
        }
        - 1
      {
        True -> Error(Nil)
        False -> index_of_loop(y_array, predicate, index + 1)
      }
  }
}

@external(javascript, "../yArray.mjs", "get")
pub fn get(y_array: y.Array, index: Int) -> Dynamic

@external(javascript, "../yArray.mjs", "slice")
pub fn slice(y_array: y.Array, start: Int, end: Int) -> y.Array

@external(javascript, "../yArray.mjs", "toList")
pub fn to_list(y_array: y.Array) -> List(Dynamic)

@external(javascript, "../yArray.mjs", "toJSON")
pub fn to_json(y_array: y.Array) -> Dynamic

@external(javascript, "../yArray.mjs", "forEach")
pub fn for_each(
  y_array: y.Array,
  cb: fn(Dynamic, Int, y.Array) -> Nil,
) -> y.Array

@external(javascript, "../yArray.mjs", "map")
pub fn map(
  y_array: y.Array,
  cb: fn(Dynamic, Int, y.Array) -> value,
) -> List(value)

@external(javascript, "../yArray.mjs", "clone")
pub fn clone(y_array: y.Array) -> y.Array

@external(javascript, "../yArray.mjs", "observe")
pub fn observe(
  y_array: y.Array,
  cb: fn(YArrayEvent, y.Transaction) -> Nil,
) -> fn() -> Nil

@external(javascript, "../yArray.mjs", "observeDeep")
pub fn observe_deep(
  y_array: y.Array,
  cb: fn(List(AnyYEvent), y.Transaction) -> Nil,
) -> fn() -> Nil
