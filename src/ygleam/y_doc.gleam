import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import ygleam/y

@external(javascript, "../yDoc.mjs", "decode")
fn do_decode(data: Dynamic) -> Result(y.Doc, y.Doc)

pub fn decoder() -> decode.Decoder(y.Doc) {
  decode.new_primitive_decoder("y.Doc", do_decode)
}

@external(javascript, "../yDoc.mjs", "do_new")
pub fn new() -> y.Doc

@external(javascript, "../yDoc.mjs", "clientID")
pub fn client_id(y_doc: y.Doc) -> String

@external(javascript, "../yDoc.mjs", "gc")
pub fn gc(y_doc: y.Doc) -> Bool

@external(javascript, "../yDoc.mjs", "transact")
pub fn transact(y_doc: y.Doc, cb: fn() -> outcome, origin: a) -> outcome

@external(javascript, "../yDoc.mjs", "getArray")
pub fn get_array(y_doc: y.Doc, name: String) -> y.Array

@external(javascript, "../yDoc.mjs", "getMap")
pub fn get_map(y_doc: y.Doc, name: String) -> y.Map

@external(javascript, "../yDoc.mjs", "getText")
pub fn get_text(y_doc: y.Doc, name: String) -> y.Text

@external(javascript, "../yDoc.mjs", "getXmlElement")
pub fn get_xml_element(y_doc: y.Doc, name: String) -> y.XmlElement

@external(javascript, "../yDoc.mjs", "getXmlFragment")
pub fn get_xml_fragment(y_doc: y.Doc, name: String) -> y.XmlFragment

@external(javascript, "../yDoc.mjs", "destroy")
pub fn destroy(y_doc: y.Doc) -> Nil

@external(javascript, "../yDoc.mjs", "onBeforeTransaction")
pub fn on_before_transaction(
  y_doc: y.Doc,
  cb: fn(y.Transaction, y.Doc) -> Nil,
) -> Nil

@external(javascript, "../yDoc.mjs", "onBeforeObserverCalls")
pub fn on_before_observer_calls(
  y_doc: y.Doc,
  cb: fn(y.Transaction, y.Doc) -> Nil,
) -> Nil

@external(javascript, "../yDoc.mjs", "onAfterTransaction")
pub fn on_after_transaction(
  y_doc: y.Doc,
  cb: fn(y.Transaction, y.Doc) -> Nil,
) -> Nil

@external(javascript, "../yDoc.mjs", "onUpdate")
pub fn on_update(
  y_doc: y.Doc,
  cb: fn(BitArray, a, y.Doc, y.Transaction) -> Nil,
) -> Nil

@external(javascript, "../yDoc.mjs", "onUpdateV2")
pub fn on_update_v2(
  y_doc: y.Doc,
  cb: fn(BitArray, a, y.Doc, y.Transaction) -> Nil,
) -> Nil

@external(javascript, "../yDoc.mjs", "onSubdocs")
pub fn on_subdocs(
  y_doc: y.Doc,
  cb: fn(List(y.Doc), List(y.Doc), List(y.Doc)) -> Nil,
) -> Nil

@external(javascript, "../yDoc.mjs", "onDestroy")
pub fn on_destroy(y_doc: y.Doc, cb: fn(y.Doc) -> Nil) -> Nil
