# godot-node-array

A Godot 4 editor plugin that procedurally arranges scene instances along an axis — configurable count, spacing, and per-step rotation/scale offsets. Useful for fences, stairs, columns, pipes, and other repetitive geometry without manual placement.

## Requirements

- Godot 4.x
- `make` (for the convenience targets)

## Installation

### From the Asset Library
Search for **NodeArray** in the Godot Asset Library and click Install.

### Manual
Copy `addons/node_array/` into your project's `addons/` folder, then enable **NodeArray** in **Project → Project Settings → Plugins**.

## Usage

1. Add a **NodeArray3D** node to your scene.
2. Assign a `PackedScene` to the **Source Scene** property.
3. Adjust the parameters in the inspector — the array rebuilds live in the editor.

| Property | Type | Description |
|---|---|---|
| `source_scene` | PackedScene | The scene to instantiate at each step |
| `count` | int | Number of instances (minimum 1) |
| `offset` | Vector3 | Per-step translation |
| `rotation_offset` | Vector3 | Per-step rotation delta (Euler radians) |
| `scale_offset` | Vector3 | Per-step additive scale delta |

Scale at step `i` = `Vector3.ONE + scale_offset * i`, so a `scale_offset` of `(0, 0, 0)` keeps uniform scale throughout.

## Development Setup

After cloning, fetch the GUT test dependency:

```bash
git clone https://github.com/your-username/godot-node-array.git
cd godot-node-array
make setup
```

This runs `git submodule update --init` to pull [GUT](https://github.com/bitwes/Gut) into `addons/gut/`. GUT is a dev dependency and is not included in the plugin itself.

Open the project in Godot once after setup — both plugins (NodeArray and GUT) will enable automatically.

## Running Tests

```bash
make test
```

Runs the GUT test suite headless and exits with a non-zero code on failure, suitable for CI.

If `godot` is not on your `PATH`:

```bash
make test GODOT="/path/to/godot"
```

Tests live in `test/unit/`. The core layout logic (`ArrayLayout`) is fully unit-tested without a running scene tree.

## Project Structure

```
addons/
  node_array/
    plugin.cfg          # Asset Library metadata
    plugin.gd           # EditorPlugin — registers NodeArray3D custom type
    array_layout.gd     # Pure layout logic: computes Transform3D[] from params
    node_array_3d.gd    # @tool Node3D — drives layout, manages generated children
test/
  unit/
    test_array_layout.gd  # GUT unit tests
Makefile                  # setup and test targets
```

## License

[MIT](LICENSE)
