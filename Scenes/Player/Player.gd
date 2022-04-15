extends KinematicBody

const GRAVITY = 15

var MOUSE_SENSITIVITY = 0.07

var is_in_settings_pop = false
var show_crosshair = false
var accel = 20
var speed = 10
var jump = 7
var health = 100
var sprint = 15
var money = 500
var frags = 2

var direction: Vector3
var velocity: Vector3
var fall: Vector3

var gun
var active_guns = []
var current_gun = 0

onready var cam = $Head/Camera
onready var head = $Head
onready var hand = $Head/Hand
onready var pocket = $Head/Pocket
onready var crosshair = $Head/Camera/GUI/Crosshair
onready var reach = $Head/Camera/Reach
onready var aimcast = $Head/Camera/AimCast
onready var health_labl = $Head/Camera/GUI/HealthContainer/Health
onready var money_labl = $Head/Camera/GUI/MoneyContainer/Money
onready var settings_pop = $Head/Camera/GUI/Settings
onready var knife = $Head/Melee/Knife

var grenade = preload("res://Scenes/Player/Grenade.tscn")

# Functions
func _ready():
	randomize()

func _process(delta):
	# Render UI
	health_labl.text = "Health: " + str(health)
	money_labl.text = "$" + str(money)
# _process

func _physics_process(delta):
	handle_guns(delta)
# _physics_process

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
			
			if aimcast.is_colliding() and gun.is_in_hand:
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
			elif reach.get_collider().has_method("buy"):
				var buy_item = reach.get_collider().buy()

				match buy_item["type"]:
					"AMMO": buy_ammo(buy_item["cost"])
		# end reach colliding
	# end interact input
	
	if Input.is_action_just_pressed("k_frag"):
		if frags >= 1:
			# spawn / throw frag
			var nade = grenade.instance()
			self.get_parent().add_child(nade)
			nade.global_transform = head.global_transform
			nade.apply_impulse(Vector3.ZERO, nade.global_transform.basis.z * 40)
			
			frags -= 1
	
	if Input.is_action_just_pressed("k_melee"):
		knife.melee()
	
# handle_guns

func buy_ammo(cost):
	if money >= cost:
		var needs_ammo = false
		for g in hand.get_children():
			if g.ammo_spare == g.max_ammo_in_mag * 3:
				continue
			g.ammo_spare = g.max_ammo_in_mag * 3
			g.ammo_left = g.max_ammo_in_mag
			needs_ammo = true
		if needs_ammo:
			money -= cost
			print("Buying ammo")
		else:
			print("Already have max ammo")

func load_gun():
	for g in hand.get_children():
		g.visible = false
		g.picked_up = false
		g.is_in_hand = false
	gun = hand.get_child(current_gun)
	gun.rotation = hand.rotation
	gun.visible = true
	gun.picked_up = true  # Set ammo counter
	gun.is_in_hand = true

func take_dmg(dmg, body):
	if is_in_settings_pop:
		return
	health -= dmg
	if health <= 0:
		print("ded")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene("res://Scenes/GUI/Main.tscn")

# Helper functions
func get_is_mouse_captured() -> bool:
	return Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED

func _on_Area_body_entered(body):
	pass
#	if body.is_in_group("Players") or body.is_in_group("Bullets"):
#		print("Should load scene")
#		get_tree().change_scene("res://Scenes/Maps/TestMap/TestMap.tscn")

func _on_Close_pressed():
	settings_pop.visible = false
	is_in_settings_pop = false
	show_crosshair = true

func _on_Quit_pressed():
	get_tree().quit(0)
