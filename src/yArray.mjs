import * as Y from "yjs";

import { List, Ok, Error } from "./gleam.mjs";

import { YArrayError, LengthExceeded } from "./ygleam/y_array.mjs";

import * as AbstractType from "./abstractType.mjs";

export function decode(data) {
  if (data instanceof Y.Array) {
    return new Ok(data);
  }

  return new Error(new Y.Array());
}

export function do_new() {
  return new Y.Array();
}

export function doc(yArray) {
  return AbstractType.doc(yArray);
}

export function parent(yArray) {
  return AbstractType.parent(yArray);
}

export function from(contentList) {
  return Y.Array.from(contentList);
}

export function length(yArray) {
  return yArray.length;
}

export function insert(yArray, index, contentList) {
  try {
    yArray.insert(index, contentList);
  } catch (e) {
    if (e.message?.toLowerCase().includes("length exceeded")) {
      return new Error(new LengthExceeded());
    } else {
      return new Error(new YArrayError());
    }
  }

  return new Ok(yArray);
}

// `delete` is a reserved word
export function delete_from_index(yArray, index, length) {
  try {
    yArray.delete(index, length);
  } catch (e) {
    if (
      e instanceof Error &&
      e.message?.toLowerCase().includes("length exceeded")
    ) {
      return new Error(new LengthExceeded());
    } else {
      return new Error(new YArrayError());
    }
  }

  return new Ok(yArray);
}

export function push(yArray, contentList) {
  yArray.push(contentList);

  return yArray;
}

export function unshift(yArray, contentList) {
  yArray.unshift(contentList);

  return yArray;
}

export function get(yArray, index) {
  return yArray.get(index);
}

export function slice(yArray, start, end) {
  return yArray.slice(start, end);
}

export function toList(yArray) {
  return List.fromArray(yArray.toArray());
}

export function toJSON(yArray) {
  return yArray.toJSON();
}

export function forEach(yArray, cb) {
  yArray.forEach((yValue, index, yArray) => cb(yValue, index, yArray));

  return yArray;
}

export function map(yArray, cb) {
  return List.fromArray(
    yArray.map((yValue, index, yArray) => cb(yValue, index, yArray)),
  );
}

export function clone(yArray) {
  return yArray.clone();
}

export function observe(yArray, cb) {
  return AbstractType.observe(yArray, cb);
}

export function observeDeep(yArray, cb) {
  return AbstractType.observeDeep(yArray, cb);
}
