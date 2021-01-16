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

# Functions
func _ready():
	audio.connect("finished", self, "destroy")

func _process(delta):
	if dropped:
		# Drop it forward
		self.apply_impulse(self.transform.basis.z, -transform.basis.z * 5)
		dropped = false

func shoot():
	if ap.is_playing() or audio.playing:
		return

	var b = bullet_scn.instance()
	fp.add_child(b)
	b.global_transform = self.global_transform
	b.translate(-transform.basis.z * 2)
	b.DAMAGE = 34
	b.SPEED = 80

	ap.play("ARFire")
	audio.stream = sound_rifle
	audio.play()
# shoot

func reload():
	if ap.is_playing():
		return
		
	ap.play("ARReload")
	audio.stream = sound_reload
	audio.play()
# reload

func destroy():
	audio.stop()
