# YGleam

Gleam bindings to [Yjs](https://github.com/yjs/yjs)

## Library state

The bindings to YDoc, YMap, YArray, YUndoManager and their event listeners are
solid. They are used in production daily at [Nestful](https://nestful.app).

Other parts of the code were written on a best-effort basis and are untested, as
we currently do not use them in Nestful. PRs welcome.

## API state

This library binds from a functional, immutable, type-safe language (Gleam), to
a dynamic JavaScript API. This proves challenging. We are fairly close to a 1.0,
with a nice, ergonomic, as close to riding-on-a-cloud as possible, but not quite
there yet. Expect breaking changes.

Do open an issue if you have an API suggestion.

## Usage

Currently this library is almost a one-to-one FFI to Yjs, so first please
consult their respective docs at [https://yjs.dev](https://yjs.dev).

Here's an example for saving some Pets:

```gleam
import gleam/dynamic/decode.{type Dynamic}
import ygleam/y
import ygleam/y_doc
import ygleam/y_map
import ygleam/y_array

type Pet {
    Pet(name: String, species: String)
}

fn encode_pet(pet: Pet) -> y.Value {
    let ymap = y_map.new()
    ymap
    |> y_map.set("name", y.string(pet.name))
    |> y_map.set("species", y.string(pet.species))
    |> y.map
}

fn pet_decoder() {
    use name <- decode.field("name", decode.string)
    use species <- decode.field("species", decode.string)
}

fn decode_pet(dyn_pet: Dynamic) {
    decode.run(dyn_pet, y_map.decoder())
    |> result.map(y_map.to_json)
    |> result.then(decode.run(_, pet_decoder()))
}

fn decode_pet_name(dyn_pet: Dynamic) -> String {
    decode.run(dyn_pet, y_map.decoder())
    |> result.map(y_map.get("species"))
    |> result.then(decode.run(_, decode.string))
}

let ydoc = y_doc.new()

let pets = y_doc.get_array(ydoc, "pets")

[
    Pet(name: "Doggo", species: "Dog"),
    Pet(name: "Catto", species: "Cat")
]
|> list.map(encode_pet)
|> y_array.push(pets)

get(pets, 0)
|> decode_pet
|> echo

get(pets, 1)
|> decode_pet_name
|> echo

```

### Sponsored by Nestful

<a href="https://nestful.app">
  <p align="center">
    <img src="nestful.png">
  </p>
</a>

YGleam is developed for and sponsored by [Nestful](https://nestful.app), the best
app there is to manage your own time.
