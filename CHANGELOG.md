# Changelog

## v0.8.0

- BREAKING: Yjs shared types and returned values are not longer wrapped in
  custom types. Instead, `Dynamic` is returned when fetching, and a new type,
  `y.Value`, is used for input. Please consult the usage example in the README.
- BREAKING: Upgrade depdencies
  -> Moved to gleam/yielder where needed
  -> Requires Gleam 1.9

## v0.7.0

- Fix UndoManager creation
- Add `undo_manager.clear`
- Upgrade depdencies

## v0.6.0

- BREAKING: Upgrade depdencies (major versions)

## v0.5.0

- Seems like some people are using this libray, so properly keep a changelog
- BREAKING: Change YEvent's `ChangesKeys` to a more ergonomic type

## v0.3.0

- Undocumented

## v0.3.0

- Undocumented

## v0.2.0

- Undocumented

## v0.1.0

- Initial Release
