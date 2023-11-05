extends RigidBody3D


var shoot = false

var DAMAGE = 50
var SPEED = 50

var self_impulse

# Called when the node enters the scene tree for the first time.
func _ready():
	lock_rotation = true
	gravity_scale = 0
	global_rotation.x += 90


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self_impulse = transform.basis * (Vector3.FORWARD)
	add_constant_central_force(self_impulse * SPEED)


func _on_area_3d_body_entered(body):
	if body.is_in_group("physic"):
		body.apply_impulse(self_impulse * 1,global_transform.origin + self_impulse)
	
	queue_free()
