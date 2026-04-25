@tool
class_name NodeArray3D
extends Node3D
## Procedurally arranges instances of a PackedScene as children.
## All parameters are live-editable in the inspector; the array rebuilds
## automatically whenever a value changes or the node enters the tree.

const _GENERATED_GROUP := &"_node_array_generated"

# Backing vars let setters clamp/validate without recursing.
var _source_scene: PackedScene
var _count: int = 3
var _offset: Vector3 = Vector3(2.0, 0.0, 0.0)
var _rotation_offset: Vector3 = Vector3.ZERO
var _scale_offset: Vector3 = Vector3.ZERO


@export var source_scene: PackedScene:
	get: return _source_scene
	set(v):
		_source_scene = v
		if is_inside_tree():
			_rebuild()

@export var count: int = 3:
	get: return _count
	set(v):
		_count = maxi(1, v)
		if is_inside_tree():
			_rebuild()

@export var offset: Vector3 = Vector3(2.0, 0.0, 0.0):
	get: return _offset
	set(v):
		_offset = v
		if is_inside_tree():
			_rebuild()

@export var rotation_offset: Vector3 = Vector3.ZERO:
	get: return _rotation_offset
	set(v):
		_rotation_offset = v
		if is_inside_tree():
			_rebuild()

@export var scale_offset: Vector3 = Vector3.ZERO:
	get: return _scale_offset
	set(v):
		_scale_offset = v
		if is_inside_tree():
			_rebuild()


func _ready() -> void:
	_rebuild()


func _rebuild() -> void:
	_clear_generated()
	if _source_scene == null or _count <= 0:
		return
	var transforms := ArrayLayout.compute_transforms(
		_count, _offset, _rotation_offset, _scale_offset
	)
	for t: Transform3D in transforms:
		var instance := _source_scene.instantiate()
		if not instance is Node3D:
			push_error("NodeArray3D: source_scene root must extend Node3D")
			instance.free()
			return
		add_child(instance)
		instance.add_to_group(_GENERATED_GROUP)
		(instance as Node3D).transform = t
		if Engine.is_editor_hint() and get_tree():
			instance.owner = get_tree().edited_scene_root


func _clear_generated() -> void:
	for child in get_children():
		if child.is_in_group(_GENERATED_GROUP):
			child.free()
