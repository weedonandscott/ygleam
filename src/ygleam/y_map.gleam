import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/option.{type Option}
import gleam/yielder.{type Yielder}
import ygleam/y
import ygleam/y_event.{type AnyYEvent, type ChangesKeys, type YMapEvent}

@external(javascript, "../yMap.mjs", "decode")
fn do_decode(data: Dynamic) -> Result(y.Map, y.Map)

pub fn decoder() -> decode.Decoder(y.Map) {
  decode.new_primitive_decoder("y.Map", do_decode)
}

@external(javascript, "../yMap.mjs", "do_new")
pub fn new() -> y.Map

@external(javascript, "../yMap.mjs", "doc")
pub fn doc(y_map: y.Map) -> Option(y.Doc)

@external(javascript, "../yMap.mjs", "parent")
pub fn parent(y_map: y.Map) -> Option(Dynamic)

@external(javascript, "../yMap.mjs", "set")
pub fn set(y_map: y.Map, key: String, value: y.Value) -> y.Map

@external(javascript, "../yMap.mjs", "getDynamic")
pub fn get(y_map: y.Map, key: String) -> dynamic.Dynamic

@external(javascript, "../yMap.mjs", "deleteKey")
pub fn delete(y_map: y.Map, key: String) -> y.Map

@external(javascript, "../yMap.mjs", "has")
pub fn has(y_map: y.Map, key: String) -> Bool

@external(javascript, "../yMap.mjs", "toJSON")
pub fn to_json(y_map: y.Map) -> Dynamic

@external(javascript, "../yMap.mjs", "size")
pub fn size(y_map: y.Map) -> Int

@external(javascript, "../yMap.mjs", "forEach")
pub fn for_each(y_map: y.Map, cb: fn(Dynamic, String, y.Map) -> Nil) -> y.Map

@external(javascript, "../yMap.mjs", "entries")
pub fn entries(y_map: y.Map) -> Yielder(#(String, Dynamic))

@external(javascript, "../yMap.mjs", "values")
pub fn values(y_map: y.Map) -> Yielder(Dynamic)

@external(javascript, "../yMap.mjs", "keys")
pub fn keys(y_map: y.Map) -> Yielder(String)

@external(javascript, "../yMap.mjs", "clone")
pub fn clone(y_map: y.Map) -> y.Map

@external(javascript, "../yMap.mjs", "observe")
pub fn observe(
  y_map: y.Map,
  cb: fn(YMapEvent, ChangesKeys, y.Transaction) -> Nil,
) -> fn() -> Nil

@external(javascript, "../yMap.mjs", "observeDeep")
pub fn observe_deep(
  y_map: y.Map,
  cb: fn(List(AnyYEvent), y.Transaction) -> Nil,
) -> fn() -> Nil
