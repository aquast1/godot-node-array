class_name ArrayLayout
## Pure layout logic: maps array parameters to an ordered list of Transform3D.
## No nodes, no scenes — keeps this testable without a running scene tree.


## Returns [count] transforms spaced by [offset], each step adding
## [rotation_offset] (Euler radians, YXZ order) and [scale_offset] to scale.
## Index 0 is always at origin with identity rotation and scale 1.
static func compute_transforms(
	count: int,
	offset: Vector3,
	rotation_offset: Vector3,
	scale_offset: Vector3,
) -> Array[Transform3D]:
	var result: Array[Transform3D] = []
	result.resize(count)
	for i in count:
		var pos := offset * i
		var rot := rotation_offset * i
		var scl := Vector3.ONE + scale_offset * i
		var basis := Basis.from_euler(rot).scaled(scl)
		result[i] = Transform3D(basis, pos)
	return result
