extends RayCast3D

var distance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculating the distance between the laser and a collision point.
	distance = get_collision_point().distance_to(global_transform.origin)
	# Scaler is scaling to the collision point.
	if is_colliding():
		print(distance)
		$CSGCylinder3D.position.y = (distance / 2) * -1
		$CSGCylinder3D.height = distance
