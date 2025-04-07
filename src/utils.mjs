import { unfold, Done, Next } from "../gleam_yielder/gleam/yielder.mjs";

export function identity(something) {
  return something;
}

export function do_null() {
  return null;
}

export function do_object(entries) {
  return Object.fromEntries(entries);
}

export function do_array(list) {
  return list.toArray();
}

export function bitArray(bitArray) {
  return bitArray.rawBuffer;
}

export function toGleamYielder(jsIterator, transformer) {
  return unfold(jsIterator, (iter) => {
    const next = iter.next();
    if (!next || next.done) {
      return new Done();
    } else {
      return new Next(transformer ? transformer(next.value) : next.value, iter);
    }
  });
}
