extends RigidBody

onready var ap = $AnimationPlayer
onready var hitarea = $Area

var fire_speed
var damage

var dropped = false
var picked_up = false
var is_blocking_aim = false
var is_in_hand = false
var ammo_label: Label

# Functions
func _init(_dmg=151, _fs=1).():
	fire_speed = _fs
	damage = _dmg

func _ready():
	ammo_label = get_tree().get_nodes_in_group("Ammo")[0]


func _process(delta):
	if dropped:
		# Drop it forward
		self.apply_impulse(self.transform.basis.z, -transform.basis.z * 5)
		dropped = false
	if picked_up:
		ammo_label.text = "Ammo: N/A"
# _process

func melee():
	if ap.is_playing():
		return
	var bodies = hitarea.get_overlapping_bodies()
	if bodies:
		for b in bodies:
			if b.has_method("bullet_hit"):
				b.bullet_hit(damage, self.global_transform)
	# For the player
	ap.play("Melee", -1, fire_speed)
	
# melee

func inspect_wpn():
	ap.play("ARInspect")

func equip_wpn():
	print("Replace this with an equip animation")

func reload():
	pass
# reload

func destroy():
	pass

# To inherit later
func init_vars(): 
	pass
