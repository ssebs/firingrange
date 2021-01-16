extends KinematicBody

const GRAVITY = 9.8

export var MOUSE_SENSITIVITY = 0.07

var show_crosshair = false
var accel = 20
var speed = 10
var jump = 5

var direction: Vector3
var velocity: Vector3
var fall: Vector3
var gun
var wpn_to_spawn
var wpn_to_drop

onready var cam = $Head/Camera
onready var head = $Head
onready var hand = $Head/Hand
onready var crosshair = $Head/Camera/TextureRect
onready var reach = $Head/Camera/Reach


# For mouse input
func _input(event):
	# Click to capture mouse
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and not get_is_mouse_captured():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		show_crosshair = true
	# Cancel capture mouse
	if Input.is_action_just_pressed("ui_cancel") and get_is_mouse_captured():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		show_crosshair = false
	
	# Camera movement
	if event is InputEventMouseMotion and get_is_mouse_captured():
		self.rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
		head.rotate_x(deg2rad(-event.relative.y * MOUSE_SENSITIVITY))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-70), deg2rad(70))
# _input

func _process(delta):
	crosshair.show() if show_crosshair else crosshair.hide()
	
	# Choose gun to pickup
	if reach.is_colliding() and reach.get_collider():
		if reach.get_collider().has_method("shoot"):
			wpn_to_spawn = load(reach.get_collider().filename).instance()
#			print(wpn_to_spawn)
		else:
			wpn_to_spawn = null
	else:
		wpn_to_spawn = null
	
	# Choose a gun to drop
	if hand.get_child(0) != null:
		wpn_to_drop = load(hand.get_child(0).filename).instance()
#		print(wpn_to_drop)
	else:
		wpn_to_drop = null
	
# _process

func _physics_process(delta):
	handle_movement(delta)
	handle_guns(delta)
# _physics_process

func handle_movement(delta):
	direction = Vector3()
	
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
		
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	velocity = self.move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
# handle_movement

func handle_guns(delta):
	# Shoot
	if Input.is_action_just_pressed("fire"):
		if gun: gun.shoot()
			
	# Reload
	if Input.is_action_just_pressed("reload"):
		if gun: gun.reload()

	# Pickup and drop gun
	if Input.is_action_just_pressed("interact"):
		if wpn_to_spawn != null:
			if hand.get_child(0) != null:
				self.get_parent().add_child(wpn_to_drop)
				wpn_to_drop.global_transform = hand.global_transform
				wpn_to_drop.dropped = true
				hand.get_child(0).queue_free()
			reach.get_collider().queue_free()
			hand.add_child(wpn_to_spawn)
			wpn_to_spawn.rotation = hand.rotation
			gun = wpn_to_spawn
# handle_guns


# Helper functions
func get_is_mouse_captured() -> bool:
	return Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
# get_is_mouse_captured
