@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type(
		"NodeArray3D",
		"Node3D",
		preload("node_array_3d.gd"),
		null
	)


func _exit_tree() -> void:
	remove_custom_type("NodeArray3D")
