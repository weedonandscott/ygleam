import gleam/dict
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}

pub type AbstractType

pub type Transaction

pub type Doc

pub type Map

pub type Array

pub type Text

pub type XmlFragment

pub type XmlElement

/// The Value type represents the JavaScript types Yjs can hold:
///   - null
///   - String
///   - Boolean
///   - Number
///   - Uint8Array
///   - Array<Value>
///   - Object<String, Value>
///   - Any Yjs type
pub type Value

@external(javascript, "../utils.mjs", "identity")
fn do_coerce(a: any) -> Value

/// Encodes a String to a y.Value
pub fn string(input: String) -> Value {
  do_coerce(input)
}

/// Encodes a Bool to a y.Value
pub fn bool(input: Bool) -> Value {
  do_coerce(input)
}

/// Encodes an Int to a y.Value
pub fn int(input: Int) -> Value {
  do_coerce(input)
}

/// Encodes a Float to a y.Value
pub fn float(input: Float) -> Value {
  do_coerce(input)
}

/// Encodes a BitArray to a y.Value
@external(javascript, "../utils.mjs", "bitArray")
pub fn bit_array(input: BitArray) -> Value

/// Creates a null y.Value
@external(javascript, "../utils.mjs", "do_null")
pub fn null() -> Value

/// Encodes a Yjs Map to a y.Value
pub fn map(input: Map) -> Value {
  do_coerce(input)
}

/// Encodes a Yjs Array to a y.Value
pub fn array(input: Array) -> Value {
  do_coerce(input)
}

/// Encodes a Yjs Text to a y.Value
pub fn text(input: Text) -> Value {
  do_coerce(input)
}

/// Encodes a Yjs XmlFragment to a y.Value
pub fn xml_fragment(input: XmlFragment) -> Value {
  do_coerce(input)
}

/// Encodes a Yjs XmlElement to a y.Value
pub fn xml_element(input: XmlElement) -> Value {
  do_coerce(input)
}

/// Encodes an optional value into a y.Value, using `null` if `None`
pub fn nullable(from input: Option(a), of inner_type: fn(a) -> Value) -> Value {
  case input {
    Some(value) -> inner_type(value)
    None -> null()
  }
}

/// Encode a list of key-value pairs into a JSON object.
@external(javascript, "../utils.mjs", "do_object")
pub fn object(entries: List(#(String, Value))) -> Value

@external(javascript, "../utils.mjs", "do_array")
pub fn preprocessed_js_array(from: List(Value)) -> Value

/// Encode a list into a JS array.
pub fn js_array(from entries: List(a), of inner_type: fn(a) -> Value) -> Value {
  entries
  |> list.map(inner_type)
  |> preprocessed_js_array
}

pub fn from_json(from: json.Json) -> Value {
  do_coerce(from)
}

/// Encode a Dict into a JSON object using the supplied functions to encode
/// the keys and the values respectively.
pub fn dict(
  dict: dict.Dict(k, v),
  keys: fn(k) -> String,
  values: fn(v) -> Value,
) -> Value {
  object(dict.fold(dict, [], fn(acc, k, v) { [#(keys(k), values(v)), ..acc] }))
}
