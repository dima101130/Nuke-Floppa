extends CharacterBody3D

@onready var cam = $Head/Camera3D

#movment
@export var walk_speed := 6.0
@export var sprint_speed := 10.0

@export var gravity := 9.8
@export var jump_power := 10.0
@export var h_accel := 35.0
@export var v_accel := 35.0

var speed

var mousepos = Vector2()

func _ready():
	pass


func _physics_process(delta):
	var mousepos = get_viewport().get_mouse_position()
	
	var worldspace = get_world_3d().direct_space_state
	var start = cam.project_ray_origin(mousepos)
	var end = cam.project_position(mousepos,1000)
	var query = PhysicsRayQueryParameters3D.create(start, end)
	query.collide_with_areas = true
	var result = worldspace.intersect_ray(query)
	if result:
		print(result.position)
	
	# Horizontal movement
	var horizontal_input := Vector3.ZERO
	horizontal_input.z = Input.get_axis("forward", "backward")
	horizontal_input.x = Input.get_axis("left", "right")
	
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	else:
		speed = walk_speed
	
	horizontal_input = horizontal_input.limit_length(1.0)
	horizontal_input *= speed
	horizontal_input.y = velocity.y
	
	velocity = velocity.move_toward(horizontal_input, h_accel * delta)
	
	# Vertical movement
	velocity.y = move_toward(velocity.y, -gravity, v_accel * delta)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power
		
	
	move_and_slide()
	
