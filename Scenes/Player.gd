extends KinematicBody

const GRAVITY = 9.8

var MOUSE_SENSITIVITY = 0.07

var show_crosshair = false
var accel = 20
var speed = 10
var jump = 5
var health = 100

var direction: Vector3
var velocity: Vector3
var fall: Vector3

var gun
var wpn_to_spawn
var wpn_to_drop

var primary_gun
var secondary_gun


onready var cam = $Head/Camera
onready var head = $Head
onready var hand = $Head/Hand
onready var crosshair = $Head/Camera/GUI/Crosshair
onready var reach = $Head/Camera/Reach
onready var aimcast = $Head/Camera/AimCast
onready var inventory = $Head/Inventory
onready var health_labl = $Head/Camera/GUI/HealthContainer/Health
onready var settings_pop = $Head/Camera/GUI/Settings

var is_in_settings_pop = false

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
	
	# Choose gun to pickup
	if reach.is_colliding() and reach.get_collider():
		if reach.get_collider().has_method("shoot"):
			wpn_to_spawn = load(reach.get_collider().filename).instance()
			wpn_to_spawn.picked_up = true
			primary_gun = wpn_to_spawn
#			print(wpn_to_spawn)
		else:
			wpn_to_spawn = null
	else:
		wpn_to_spawn = null
	
	# Choose a gun to drop
	if hand.get_child(0) != null:
		# fix
		if secondary_gun == null:
			secondary_gun = load(hand.get_child(0).filename).instance()
		else:
			wpn_to_drop = load(hand.get_child(0).filename).instance()
#		print(wpn_to_drop)
	else:
		wpn_to_drop = null
	
	# Render health
	health_labl.text = "  Health: " + str(health)
# _process

func _physics_process(delta):
	handle_movement(delta)
	handle_guns(delta)
# _physics_process

func handle_movement(delta):
	if is_in_settings_pop:
		return
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
	if is_in_settings_pop:
		return
	# Shoot
	if Input.is_action_pressed("fire"):
		if gun:
			var recoil_y = rand_range(0,gun.h_recoil)
			var recoil_x = rand_range(-gun.v_recoil, gun.v_recoil)
			
			head.rotate_x(deg2rad(recoil_y/10))
			self.rotate_y(deg2rad(recoil_x/10))
			
			if aimcast.is_colliding():
				gun.shoot(aimcast.get_collision_point())
			else:
				gun.shoot(null)
	# Reload
	if Input.is_action_just_pressed("reload"):
		if gun: gun.reload()
		
	if Input.is_action_just_pressed("inspect"):
		if gun: gun.inspect_wpn()

	# TODO: fix
	# Switch weapons
	if Input.is_action_just_pressed("gun1"):
		gun = primary_gun
	elif Input.is_action_just_pressed("gun2"):
		gun = secondary_gun

	# Pickup and drop gun
	if Input.is_action_just_pressed("interact"):
		if wpn_to_spawn != null:
			if hand.get_child(0) != null:
				if secondary_gun == null:
					secondary_gun = wpn_to_drop
					return
				self.get_parent().add_child(wpn_to_drop)
				wpn_to_drop.global_transform = hand.global_transform
				wpn_to_drop.dropped = true
				hand.get_child(0).queue_free()
			reach.get_collider().queue_free()
			hand.add_child(wpn_to_spawn)
			wpn_to_spawn.rotation = hand.rotation
			gun = wpn_to_spawn
			primary_gun = gun
# handle_guns

func take_dmg(dmg, body):
	if is_in_settings_pop:
		return
	health -= dmg
	if health <= 0:
		print("ded")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene("res://Scenes/Main.tscn")

# Helper functions
func get_is_mouse_captured() -> bool:
	return Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
# get_is_mouse_captured

func _on_Area_body_entered(body):
	if body.is_in_group("Players") or body.is_in_group("Bullets"):
		get_tree().change_scene("res://Scenes/Maps/TestMap.tscn")


func _on_Close_pressed():
	settings_pop.visible = false
	is_in_settings_pop = false
	show_crosshair = true


func _on_Quit_pressed():
	get_tree().quit(0)
