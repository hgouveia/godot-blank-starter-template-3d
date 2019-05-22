extends Camera

export(int) var SPEED : int = 20
export(int) var MAX_SPEED : int  = 30

func _physics_process(delta : float):
	var speed : int = 0
	var direction : Vector3 = Vector3()
		
	# get the rotation of the camera
	var aim : Basis = get_global_transform().basis
	
	# check input and change direction
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	if Input.is_action_pressed("move_sprint"):
		speed = MAX_SPEED
	else:
		speed = SPEED

	# move
	direction.y = 0
	direction = direction.normalized()
	translate(direction * speed * delta)