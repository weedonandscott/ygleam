import * as Y from "yjs";

import * as AbstractType from "./abstractType.mjs";
import { toGleamYielder } from "./utils.mjs";

import { Ok, Error } from "./gleam.mjs";

export function decode(data) {
  if (data instanceof Y.Map) {
    return new Ok(data);
  }

  return new Error(new Y.Map());
}

export function do_new() {
  return new Y.Map();
}

export function doc(yMap) {
  return AbstractType.doc(yMap);
}

export function parent(yMap) {
  return AbstractType.parent(yMap);
}

export function set(yMap, key, value) {
  yMap.set(key, value);

  return yMap;
}

export function setDynamic(yMap, key, value) {
  yMap.set(key, value);

  return yMap;
}

export function get(yMap, key) {
  return yMap.get(key);
}

export function getDynamic(yMap, key) {
  return yMap.get(key);
}

// `delete` is a reserved word
export function deleteKey(yMap, key) {
  yMap.delete(key);

  return yMap;
}

export function has(yMap, key) {
  return yMap.has(key);
}

export function toJSON(yMap) {
  return yMap.toJSON();
}

export function size(yMap) {
  return yMap.size;
}

export function forEach(yMap, cb) {
  yMap.forEach((yValue, index, yMap) => cb(yValue, index, yMap));

  return yMap;
}

export function entries(yMap) {
  return toGleamYielder(yMap.entries(), (key, yValue) => [key, yValue]);
}

export function values(yMap) {
  return toGleamYielder(yMap.values());
}

export function keys(yMap) {
  return toGleamYielder(yMap.keys());
}

export function clone(yMap) {
  return yMap.clone();
}

export function observe(yMap, cb) {
  return AbstractType.observe(yMap, cb);
}

export function observeDeep(yMap, cb) {
  return AbstractType.observeDeep(yMap, cb);
}
