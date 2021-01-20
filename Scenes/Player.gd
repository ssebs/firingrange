extends KinematicBody

const GRAVITY = 20

var MOUSE_SENSITIVITY = 0.07

var show_crosshair = false
var accel = 20
var speed = 10
var jump = 5
var health = 100
var sprint = 20

var direction: Vector3
var velocity: Vector3
var fall: Vector3

var gun
var active_guns = []
var current_gun = 0

onready var cam = $Head/Camera
onready var head = $Head
onready var hand = $Head/Hand
onready var crosshair = $Head/Camera/GUI/Crosshair
onready var reach = $Head/Camera/Reach
onready var aimcast = $Head/Camera/AimCast
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
		
	if Input.is_action_just_pressed("k_inspect"):
		if gun: gun.inspect_wpn()

	# Switch weapons
	if Input.is_action_just_pressed("gun1"):
		if hand.get_child_count() > 0 and hand.get_child(0) != null:
			current_gun = 0
			load_gun()
	if Input.is_action_just_pressed("gun2"):
		if hand.get_child_count() > 1 and hand.get_child(1) != null:
			current_gun = 1
			load_gun()

	# TODO: Animation
	# Pickup and drop gun
	if Input.is_action_just_pressed("k_interact"):
		# Choose gun to pickup
		if reach.is_colliding() and reach.get_collider():
			if reach.get_collider().has_method("shoot"):
				if hand.get_child_count() == 2:
					var dropped_gun = load(hand.get_child(current_gun).filename).instance()
					self.get_parent().add_child(dropped_gun)
					dropped_gun.global_transform = hand.global_transform
					dropped_gun.dropped = true
					hand.get_child(current_gun).free()  # Delete from hand since it's loaded in the world
					
					# Create new gun
					hand.add_child(load(reach.get_collider().filename).instance())
					# Set current gun to proper slot
					hand.move_child(gun, current_gun)
				else:
					current_gun = hand.get_child_count() # Select new gun
					hand.add_child(load(reach.get_collider().filename).instance())

				load_gun()
				gun.equip_wpn()
				reach.get_collider().queue_free()  # Remove selected gun from world
#				print("Current gun: " + str(hand.get_child(current_gun)))
			# end pickup gun interact
		# end reach colliding
	# end interact input
# handle_guns

func load_gun():
	for g in hand.get_children():
		g.visible = false
		g.picked_up = false
	gun = hand.get_child(current_gun)
	gun.rotation = hand.rotation
	gun.visible = true
	gun.picked_up = true  # Set ammo counter


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

func _on_Area_body_entered(body):
	if body.is_in_group("Players") or body.is_in_group("Bullets"):
		get_tree().change_scene("res://Scenes/Maps/TestMap.tscn")

func _on_Close_pressed():
	settings_pop.visible = false
	is_in_settings_pop = false
	show_crosshair = true

func _on_Quit_pressed():
	get_tree().quit(0)
