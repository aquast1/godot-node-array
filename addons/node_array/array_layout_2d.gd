class_name ArrayLayout2D
## Pure layout logic for 2D: maps array parameters to an ordered list of Transform2D.
## No nodes, no scenes — keeps this testable without a running scene tree.


## Returns [count] transforms spaced by [offset], each step adding
## [rotation_offset] (radians) and [scale_offset] to scale.
## Index 0 is always at origin with zero rotation and scale 1.
static func compute_transforms(
	count: int,
	offset: Vector2,
	rotation_offset: float,
	scale_offset: Vector2,
) -> Array[Transform2D]:
	var result: Array[Transform2D] = []
	result.resize(count)
	for i in count:
		result[i] = Transform2D(
			rotation_offset * i,
			Vector2.ONE + scale_offset * i,
			0.0,
			offset * i,
		)
	return result
