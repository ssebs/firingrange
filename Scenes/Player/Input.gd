extends "res://Scenes/Player/Player.gd"

# Functions
func _ready():
	MOUSE_SENSITIVITY = Settings.get_setting("input","mouse_sensitivity")
	randomize()

# For mouse input
func _input(event):
	# Click to capture mouse
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and not get_is_mouse_captured() and not is_in_settings_pop:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		show_crosshair = true
	# Cancel capture mouse
	if Input.is_action_just_pressed("ui_cancel") and get_is_mouse_captured():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		show_crosshair = false
		if not is_in_settings_pop:
			show_crosshair = false
			settings_pop.visible = true
			is_in_settings_pop = true
	
	# Camera movement
	if event is InputEventMouseMotion and get_is_mouse_captured():
		self.rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
		head.rotate_x(deg2rad(-event.relative.y * MOUSE_SENSITIVITY))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-70), deg2rad(70))
# _input

func _process(delta):
	crosshair.show() if show_crosshair else crosshair.hide()
	
	# Check settings if in pause menu
	if is_in_settings_pop:
		MOUSE_SENSITIVITY = Settings.get_setting("input","mouse_sensitivity")
# _process

func _physics_process(delta):
	handle_movement(delta)
# _physics_process

func handle_movement(delta):
	if is_in_settings_pop:
		return
	direction = Vector3()
	var is_sprinting = false
	
	# Gravity
	if not self.is_on_floor():
		fall.y -= GRAVITY * delta
	
	# Jump
	if Input.is_action_pressed("jump") and is_on_floor():
		fall.y = jump
	
	# Movement
	if Input.is_action_pressed("move_forward"):
		direction -= self.transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += self.transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= self.transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += self.transform.basis.x
		
	# Sprint
	if Input.is_action_pressed("k_sprint"):
		is_sprinting = true
		
	direction = direction.normalized()

	if is_sprinting:
		velocity = velocity.linear_interpolate(direction * sprint, accel * delta)
	else:
		velocity = velocity.linear_interpolate(direction * speed, accel * delta)

	velocity = self.move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
# handle_movement


# Helper functions
func get_is_mouse_captured() -> bool:
	return Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
