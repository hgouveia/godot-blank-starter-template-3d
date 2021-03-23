extends KinematicBody

export(float) var SPEED : float = 20
export(float) var MAX_SPEED : float  = 30
export(float) var MOUSE_SENSIBILITY : float = 0.3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta : float):
	var speed : float = 0
	var direction : Vector3 = Vector3()
	
	# check input and change direction
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_pressed("move_sprint"):
		speed = MAX_SPEED
	else:
		speed = SPEED

	# move
	direction = direction.normalized()
	move_and_slide(direction * speed, Vector3.UP)
	
func _input(event):
	# mouse rotation
	if event is InputEventMouseMotion:
		self.rotate_y( deg2rad(-event.relative.x * MOUSE_SENSIBILITY) )
		$Camera.rotate_x( deg2rad(-event.relative.y * MOUSE_SENSIBILITY) )
		$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-89), deg2rad(89))
