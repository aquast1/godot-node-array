extends GutTest
## Unit tests for ArrayLayout2D.compute_transforms.


func test_returns_correct_count() -> void:
	var result := ArrayLayout2D.compute_transforms(5, Vector2(1, 0), 0.0, Vector2.ZERO)
	assert_eq(result.size(), 5)


func test_zero_count_returns_empty() -> void:
	var result := ArrayLayout2D.compute_transforms(0, Vector2(1, 0), 0.0, Vector2.ZERO)
	assert_eq(result.size(), 0)


func test_index_zero_is_at_origin() -> void:
	var result := ArrayLayout2D.compute_transforms(3, Vector2(2, 0), 0.0, Vector2.ZERO)
	assert_true(result[0].origin.is_equal_approx(Vector2.ZERO))


func test_offset_applied_per_step() -> void:
	var result := ArrayLayout2D.compute_transforms(3, Vector2(2, 0), 0.0, Vector2.ZERO)
	assert_true(result[1].origin.is_equal_approx(Vector2(2, 0)))
	assert_true(result[2].origin.is_equal_approx(Vector2(4, 0)))


func test_offset_along_y_axis() -> void:
	var result := ArrayLayout2D.compute_transforms(3, Vector2(0, 1), 0.0, Vector2.ZERO)
	assert_true(result[2].origin.is_equal_approx(Vector2(0, 2)))


func test_count_one_returns_single_origin_transform() -> void:
	var result := ArrayLayout2D.compute_transforms(1, Vector2(5, 0), 0.0, Vector2.ZERO)
	assert_eq(result.size(), 1)
	assert_true(result[0].origin.is_equal_approx(Vector2.ZERO))


func test_no_rotation_gives_zero_rotation() -> void:
	var result := ArrayLayout2D.compute_transforms(3, Vector2(1, 0), 0.0, Vector2.ZERO)
	for t: Transform2D in result:
		assert_almost_eq(t.get_rotation(), 0.0, 0.0001)


func test_rotation_offset_accumulates_per_step() -> void:
	var result := ArrayLayout2D.compute_transforms(3, Vector2.ZERO, PI / 4.0, Vector2.ZERO)
	assert_almost_eq(result[0].get_rotation(), 0.0, 0.0001)
	assert_almost_eq(result[1].get_rotation(), PI / 4.0, 0.0001)
	assert_almost_eq(result[2].get_rotation(), PI / 2.0, 0.0001)


func test_scale_offset_accumulates_per_step() -> void:
	var result := ArrayLayout2D.compute_transforms(3, Vector2.ZERO, 0.0, Vector2(0.5, 0.0))
	assert_almost_eq(result[0].get_scale().x, 1.0, 0.0001)
	assert_almost_eq(result[1].get_scale().x, 1.5, 0.0001)
	assert_almost_eq(result[2].get_scale().x, 2.0, 0.0001)


func test_uniform_scale_offset() -> void:
	var result := ArrayLayout2D.compute_transforms(2, Vector2.ZERO, 0.0, Vector2(0.1, 0.1))
	var scl := result[1].get_scale()
	assert_almost_eq(scl.x, 1.1, 0.0001)
	assert_almost_eq(scl.y, 1.1, 0.0001)


func test_combined_offset_and_rotation() -> void:
	var result := ArrayLayout2D.compute_transforms(2, Vector2(3, 0), PI / 2.0, Vector2.ZERO)
	assert_true(result[1].origin.is_equal_approx(Vector2(3, 0)))
	assert_almost_eq(result[1].get_rotation(), PI / 2.0, 0.0001)
