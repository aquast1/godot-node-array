## Project Overview
godot-node-array is a godot editor plugin that brings blender style array modifier functionality to godot nodes. It allows developers to take Node with a transform property and procedurally duplicate/arrange it along one or more axes, in a radial pattern, or following a path, in both 3D and 2D, without manually placing instances. The goal is to make level design and scene composition faster and more flexible, especially for repetitive geometry like fences, stairs, columns, pipes, modular architecture pieces, etc.

## Core Capability
Given a source node and a set of parameters, produce N arranged instances
of that node as children of a parent node. Parameters should cover at minimum:

Count: number of copies
Offset: per-step translation (X, Y, Z)
Rotation offset: per-step rotation delta
Scale offset: per-step scale delta
Fit type: fixed count vs. fit-to-length

The plugin should be installable via the asset library and work out-of-the-box with minimal configuration. It should be designed with extensibility in mind, allowing for future features like randomization, noise-based offsets, or support for 2D scenes.

## Environment
Target godot version 4.x (GDScript, not C#)

## Workflow
- Commit logical units of work as you go
- Work on main unless instructed otherwise
- Don't push unless explicitly asked

## Code Conventions
- GDScript style: typed where practical, but don't over-annotate trivial locals
- Prefer @export variables on nodes/resources for inspector-driven workflows
- Use EditorInterface.get_selection() where relevant for operating on selected nodes
- Avoid print() spam; use push_warning() / push_error() for plugin-internal issues
- Tool scripts must guard editor-only calls with if Engine.is_editor_hint()

## Testing
Tests are written using GUT (Godot Unit Test), the standard community test framework
for Godot 4. GUT is a dev dependency only — it should not be bundled with the plugin
itself.
GUT repo: https://github.com/bitwes/Gut