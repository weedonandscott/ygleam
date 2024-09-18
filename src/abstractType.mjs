import * as Y from "yjs";

import { List } from "./gleam.mjs";
import Dict from "../gleam_stdlib/dict.mjs";
import { None, Some } from "../gleam_stdlib/gleam/option.mjs";

import * as YGleamEvent from "./ygleam/y_event.mjs";

import { classifyKnownYValue, toYType } from "./utils.mjs";

export function doc(yAbstractType) {
  const doc = yAbstractType.doc;
  return doc ? Some(doc) : None;
}

export function parent(yAbstractType) {
  const parent = yAbstractType.parent;

  if (!parent) {
    return None;
  } else {
    return Some(toYType(parent));
  }
}

function changesKeys(yEvent) {
  return Dict.fromObject(
    Object.fromEntries(
      [...yEvent.changes.keys.entries()].map(([key, { action, oldValue }]) => {
        let typedAction;
        const typedOldValue = oldValue
          ? new Some(classifyKnownYValue(oldValue))
          : new None();

        if (action === "add") {
          typedAction = new YGleamEvent.AddAction(typedOldValue);
        } else if (action === "update") {
          typedAction = new YGleamEvent.UpdateAction(typedOldValue);
        } else if (action === "delete") {
          typedAction = new YGleamEvent.DeleteAction(typedOldValue);
        } else {
          typedAction = new YGleamEvent.UnknownAction(typedOldValue);
        }

        return [key, typedAction];
      }),
    ),
  );
}

export function observe(yAbstractType, cb) {
  const newHandler = (evt, t) => {
    cb(evt, changesKeys(evt), t);
  };

  yAbstractType.observe(newHandler);
  return () => yAbstractType.unobserve(newHandler);
}

export function observeDeep(yAbstractType, cb) {
  const newHandler = (events, tr) =>
    cb(
      List.fromArray(
        events.map((event) => {
          if (event instanceof Y.YArrayEvent) {
            return new YGleamEvent.ArrayEvent(event, changesKeys(event));
          } else if (event instanceof Y.YMapEvent) {
            return new YGleamEvent.MapEvent(event, changesKeys(event));
          } else if (event instanceof Y.YTextEvent) {
            return new YGleamEvent.TextEvent(event, changesKeys(event));
          } else if (event instanceof Y.YXmlEvent) {
            return new YGleamEvent.XmlEvent(event, changesKeys(event));
          } else {
            return new YGleamEvent.BaseEvent(event, changesKeys(event));
          }
        }),
      ),
      tr,
    );
  yAbstractType.observeDeep(newHandler);

  return () => yAbstractType.unobserveDeep(newHandler);
}
