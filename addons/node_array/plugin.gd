@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type(
		"NodeArray3D",
		"Node3D",
		preload("node_array_3d.gd"),
		preload("icons/node_array_3d.svg")
	)
	add_custom_type(
		"NodeArray2D",
		"Node2D",
		preload("node_array_2d.gd"),
		preload("icons/node_array_2d.svg")
	)


func _exit_tree() -> void:
	remove_custom_type("NodeArray3D")
	remove_custom_type("NodeArray2D")
