extends RigidBody

onready var bullet_scn = preload("res://Scenes/Bullet.tscn")
onready var fp = $FirePoint
onready var ap = $AnimationPlayer

onready var audio = $AudioPlayer
var sound_rifle = preload("res://Assets/Sounds/gunrifleshot.wav")
var sound_reload = preload("res://Assets/Sounds/guncock.wav")

var ammo_left = 30
var ammo_spare = 60
var max_ammo_in_mag = 30

var dropped = false
var picked_up = false
var ammo_label: Label

# Functions
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

func shoot():
	if ap.is_playing() or audio.playing:
		return
	
	if ammo_left > 0:
		# Spawn bullet
		var b = bullet_scn.instance()
		fp.add_child(b)
		b.global_transform = self.global_transform
		b.translate(-transform.basis.z * 2)
		b.DAMAGE = 25
		b.SPEED = 80
		# For the player
		ap.play("ARFire")
		audio.stream = sound_rifle
		audio.play()
		ammo_left -= 1
	else:
		reload()
	ammo_label.text = "Ammo: " + str(ammo_left) + "/" + str(ammo_spare)
# shoot

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
