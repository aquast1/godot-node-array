extends GutTest
## Unit tests for ArrayLayout.compute_transforms.
## Run via the GUT panel (install GUT from the Asset Library as a dev dependency).


func test_returns_correct_count() -> void:
	var result := ArrayLayout.compute_transforms(5, Vector3(1, 0, 0), Vector3.ZERO, Vector3.ZERO)
	assert_eq(result.size(), 5)


func test_zero_count_returns_empty() -> void:
	var result := ArrayLayout.compute_transforms(0, Vector3(1, 0, 0), Vector3.ZERO, Vector3.ZERO)
	assert_eq(result.size(), 0)


func test_index_zero_is_at_origin() -> void:
	var result := ArrayLayout.compute_transforms(3, Vector3(2, 0, 0), Vector3.ZERO, Vector3.ZERO)
	assert_almost_eq(result[0].origin, Vector3.ZERO, 0.0001)


func test_offset_applied_per_step() -> void:
	var result := ArrayLayout.compute_transforms(3, Vector3(2, 0, 0), Vector3.ZERO, Vector3.ZERO)
	assert_almost_eq(result[1].origin, Vector3(2, 0, 0), 0.0001)
	assert_almost_eq(result[2].origin, Vector3(4, 0, 0), 0.0001)


func test_offset_along_y_axis() -> void:
	var result := ArrayLayout.compute_transforms(3, Vector3(0, 1, 0), Vector3.ZERO, Vector3.ZERO)
	assert_almost_eq(result[2].origin, Vector3(0, 2, 0), 0.0001)


func test_count_one_returns_single_origin_transform() -> void:
	var result := ArrayLayout.compute_transforms(1, Vector3(5, 0, 0), Vector3.ZERO, Vector3.ZERO)
	assert_eq(result.size(), 1)
	assert_almost_eq(result[0].origin, Vector3.ZERO, 0.0001)


func test_no_rotation_offset_gives_identity_basis() -> void:
	var result := ArrayLayout.compute_transforms(3, Vector3(1, 0, 0), Vector3.ZERO, Vector3.ZERO)
	for t: Transform3D in result:
		assert_almost_eq(t.basis, Basis.IDENTITY, 0.0001)


func test_rotation_offset_accumulates_per_step() -> void:
	var step_rot := Vector3(0.0, PI / 4.0, 0.0)
	var result := ArrayLayout.compute_transforms(3, Vector3.ZERO, step_rot, Vector3.ZERO)
	# i=0: no rotation
	assert_almost_eq(result[0].basis.get_euler().y, 0.0, 0.0001)
	# i=1: PI/4
	assert_almost_eq(result[1].basis.get_euler().y, PI / 4.0, 0.0001)
	# i=2: PI/2
	assert_almost_eq(result[2].basis.get_euler().y, PI / 2.0, 0.0001)


func test_scale_offset_accumulates_per_step() -> void:
	var result := ArrayLayout.compute_transforms(3, Vector3.ZERO, Vector3.ZERO, Vector3(0.5, 0.0, 0.0))
	# i=0: scale.x = 1 + 0*0.5 = 1.0
	assert_almost_eq(result[0].basis.get_scale().x, 1.0, 0.0001)
	# i=1: scale.x = 1 + 1*0.5 = 1.5
	assert_almost_eq(result[1].basis.get_scale().x, 1.5, 0.0001)
	# i=2: scale.x = 1 + 2*0.5 = 2.0
	assert_almost_eq(result[2].basis.get_scale().x, 2.0, 0.0001)


func test_uniform_scale_offset() -> void:
	var result := ArrayLayout.compute_transforms(2, Vector3.ZERO, Vector3.ZERO, Vector3(0.1, 0.1, 0.1))
	var scl := result[1].basis.get_scale()
	assert_almost_eq(scl.x, 1.1, 0.0001)
	assert_almost_eq(scl.y, 1.1, 0.0001)
	assert_almost_eq(scl.z, 1.1, 0.0001)


func test_combined_offset_and_rotation() -> void:
	var result := ArrayLayout.compute_transforms(
		2, Vector3(3, 0, 0), Vector3(0, PI / 2.0, 0), Vector3.ZERO
	)
	assert_almost_eq(result[1].origin, Vector3(3, 0, 0), 0.0001)
	assert_almost_eq(result[1].basis.get_euler().y, PI / 2.0, 0.0001)
