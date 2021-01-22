extends RigidBody

onready var bullet_scn = preload("res://Scenes/Player/Bullet.tscn")
onready var fp = $FirePoint
onready var ap = $AnimationPlayer

onready var audio = $AudioPlayer
var sound_rifle = preload("res://Assets/Sounds/gunrifleshot.wav")
var sound_reload = preload("res://Assets/Sounds/guncock.wav")

var ammo_left
var ammo_spare
var max_ammo_in_mag
var fire_speed
var damage
var bullet_vel
var h_recoil
var v_recoil

var dropped = false
var picked_up = false
var is_blocking_aim = false
var is_in_hand = false
var ammo_label: Label

# Functions
func _init(_al=30, _as=60, _dmg=20, _fs=1, _vel=80, _hr=1, _vr=2).():
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

func _process(delta):
	if dropped:
		# Drop it forward
		self.apply_impulse(self.transform.basis.z, -transform.basis.z * 5)
		dropped = false
	if picked_up:
		ammo_label.text = "Ammo: " + str(ammo_left) + "/" + str(ammo_spare)
	
	# Block aim if reloading/inspecting/etc
	if ap.is_playing():
#		print(ap.current_animation)
		if ap.current_animation != "ARFire":
			is_blocking_aim = true
		else:
			is_blocking_aim = false
	else:
		is_blocking_aim = false

func shoot(rc_target):
	if ap.is_playing():
		return
	
	if ammo_left > 0:
		# Spawn bullet
		var b = bullet_scn.instance()
		fp.add_child(b)
		b.global_transform = fp.global_transform
		b.translate(-transform.basis.z)
		if rc_target:
			b.look_at(rc_target, Vector3.UP)
		b.DAMAGE = damage
		b.SPEED = bullet_vel
		# For the player
		ap.play("ARFire", -1, fire_speed)
		audio.stream = sound_rifle
		audio.play()
		ammo_left -= 1
	else:
		reload()
	ammo_label.text = "Ammo: " + str(ammo_left) + "/" + str(ammo_spare)
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

# To inherit later
func init_vars(): 
	pass
