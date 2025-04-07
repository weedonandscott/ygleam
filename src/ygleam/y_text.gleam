import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/json
import gleam/option.{type Option}
import ygleam/y
import ygleam/y_event.{type AnyYEvent, type YTextEvent}

@external(javascript, "../yText.mjs", "decode")
fn do_decode(data: Dynamic) -> Result(y.Text, y.Text)

pub fn decoder() -> decode.Decoder(y.Text) {
  decode.new_primitive_decoder("y.Text", do_decode)
}

@external(javascript, "../yText.mjs", "do_new")
pub fn new() -> y.Text

@external(javascript, "../yText.mjs", "doc")
pub fn doc(y_text: y.Text) -> Option(y.Doc)

@external(javascript, "../yText.mjs", "parent")
pub fn parent(y_text: y.Text) -> Option(Dynamic)

@external(javascript, "../yText.mjs", "insert")
pub fn insert(
  y_text: y.Text,
  index: Int,
  content: String,
  formattng_attributes: Option(List(#(String, json.Json))),
) -> Nil

@external(javascript, "../yText.mjs", "delete_from_index")
pub fn delete(y_text: y.Text, index: Int, length: Int) -> Nil

@external(javascript, "../yText.mjs", "format")
pub fn format(
  y_text: y.Text,
  index: Int,
  length: Int,
  formattng_attributes: List(#(String, json.Json)),
) -> Nil

// TODO
// @external(javascript, "../yText.mjs", "applyDelta")
// pub fn apply_delta(y_text: y.Text, delta, opts)

@external(javascript, "../yText.mjs", "length")
pub fn length(y_text: y.Text) -> Int

@external(javascript, "../yText.mjs", "toString")
pub fn to_string(y_text: y.Text) -> String

@external(javascript, "../yText.mjs", "toJSON")
pub fn to_json(y_text: y.Text) -> json.Json

// TODO
// @external(javascript, "../yText.mjs", "toDelta")
// pub fn to_delta(y_text: y.Text)

@external(javascript, "../yText.mjs", "observe")
pub fn observe(
  y_text: y.Text,
  cb: fn(YTextEvent, y.Transaction) -> Nil,
) -> fn() -> Nil

@external(javascript, "../yText.mjs", "observeDeep")
pub fn observe_deep(
  y_text: y.Text,
  cb: fn(List(AnyYEvent), y.Transaction) -> Nil,
) -> fn() -> Nil
