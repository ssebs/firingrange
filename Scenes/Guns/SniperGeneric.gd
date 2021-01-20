extends RigidBody

onready var bullet_scn = preload("res://Scenes/Bullet.tscn")
onready var fp = $FirePoint
onready var ap = $AnimationPlayer
onready var audio = $AudioPlayer

var sound_pistol = preload("res://Assets/Sounds/gunpistolshot.wav")
var sound_reload = preload("res://Assets/Sounds/guncock.wav")

var ammo_left
var ammo_spare
var max_ammo_in_mag
var fire_speed
var damage
var bullet_vel
var h_recoil
var v_recoil

var player
var cam

var fov = {"Default": 70, "ADS": 20}
var dropped = false
var picked_up = false
var is_blocking_aim = false
var is_in_hand = false
var ammo_label: Label
var is_aiming
var has_aimed

# Functions
func _init(_al=7, _as=21, _dmg=151, _fs=1, _vel=100, _hr=1, _vr=3).():
	ammo_left = _al
	ammo_spare = _as
	max_ammo_in_mag = _al
	fire_speed = _fs
	damage = _dmg
	bullet_vel = _vel
	h_recoil = _hr
	v_recoil = _vr

func _ready():
	audio.connect("finished", self, "destroy")
	ammo_label = get_tree().get_nodes_in_group("Ammo")[0]
	player = get_tree().get_nodes_in_group("Players")[0]
	cam = player.cam

func _process(delta):
	if dropped:
		# Drop it forward
		self.apply_impulse(self.transform.basis.z, -transform.basis.z * 5)
		dropped = false
	
	if is_in_hand:
		is_blocking_aim = true
	else:
		is_blocking_aim = false
	
	if picked_up:
		ammo_label.text = "Ammo: " + str(ammo_left) + "/" + str(ammo_spare)
		if Input.is_action_pressed("aim"):
			if not has_aimed:
				ap.play("SniperADS")
				has_aimed = true
			cam.fov =  lerp(cam.fov, fov["ADS"], 30 * delta)
			is_aiming = true
		else:
			cam.fov =  lerp(cam.fov, fov["Default"], 30 * delta)
			is_aiming = false
		
		if has_aimed and not is_aiming:
			ap.play("SniperNoADS")
			has_aimed = false
# _process

func shoot(rc_target):
	if ap.is_playing():
		return

	if ammo_left > 0:
		# Spawn bullet
		var b = bullet_scn.instance()
		fp.add_child(b)
#		b.global_transform = self.global_transform
		b.global_transform = fp.global_transform
		b.translate(-transform.basis.z)
		if rc_target:
			b.look_at(rc_target, Vector3.UP)
		b.DAMAGE = damage
		b.SPEED = bullet_vel
		
		# For the player
		ap.play("SniperFire", -1, fire_speed)
		if is_aiming:
			yield(ap, "animation_finished")
		audio.stream = sound_pistol
		audio.play()
		ammo_left -= 1
	else:
		reload()
	ammo_label.text = "Ammo: " + str(ammo_left) + "/" + str(ammo_spare)
#	print(str(ammo_left)+"/"+str(ammo_spare))
# shoot

func inspect_wpn():
	ap.play("ARInspect")

func equip_wpn():
	print("Replace this with an equip animation")

func reload():
	if ap.is_playing():
		return
		
	if ammo_spare <= 0 or ammo_left == max_ammo_in_mag:
		return
	
	var ammo_needed = max_ammo_in_mag - ammo_left
	if ammo_spare >= ammo_needed:
		ammo_spare -= ammo_needed
		ammo_left = max_ammo_in_mag
	else:
		ammo_left += ammo_spare
		ammo_spare = 0
	
	
	ap.play("ARReload")
	audio.stream = sound_reload
	audio.play()
	ammo_label.text = "Ammo: " + str(ammo_left) + "/" + str(ammo_spare)
# reload

func destroy():
	audio.stop()

