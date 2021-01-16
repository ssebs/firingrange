extends RigidBody

onready var bullet_scn = preload("res://Scenes/Bullet.tscn")
onready var fp = $FirePoint
onready var ap = $AnimationPlayer

var ammo_left = 10
var ammo_spare = 20
var max_ammo_in_mag = 10

var dropped = false


func _process(delta):
	if dropped:
		# Drop it forward
		self.apply_impulse(self.transform.basis.z, -transform.basis.z * 10)
		dropped = false

func shoot():
	if ap.is_playing():
		return
	
	
	var b = bullet_scn.instance()
	fp.add_child(b)
	b.global_transform = self.global_transform
	b.DAMAGE = 50
	b.SPEED = 10

	ap.play("Fire")
# shoot
