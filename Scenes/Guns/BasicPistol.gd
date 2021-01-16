extends RigidBody

onready var bullet_scn = preload("res://Scenes/Bullet.tscn")
onready var fp = $FirePoint
onready var ap = $AnimationPlayer

var ammo_left = 10
var ammo_spare = 20
var max_ammo_in_mag = 10

var dropped = false

## ADS
const ADS_LERP = 20

export var default_pos: Vector3
export var ads_pos: Vector3
export var cam_path: NodePath
export var crosshair_path: NodePath

var cam: Camera
var crosshair: TextureRect
var fov = {"Default": 70, "ADS": 55}

# Functions
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
	b.translate(-transform.basis.z)
	b.DAMAGE = 34
	b.SPEED = 80

	ap.play("Fire")
# shoot

func reload():
	if ap.is_playing():
		return
		
	ap.play("Reload")
# reload