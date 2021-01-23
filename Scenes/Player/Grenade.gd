extends RigidBody

export var DAMAGE = 151
export var SPEED = 20
export var GRAVITY = 20
export var TIMEOUT = 4

var hit_something = false
var timer

onready var blast_area = $BlastArea
onready var ap = $AnimationPlayer

func _ready():
	timer = Timer.new()
	self.add_child(timer)
	timer.wait_time = TIMEOUT
	timer.start()
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timeout")
	
	self.set_as_toplevel(true)

#func _on_hit(body):
#	print("Frag hit %s", body.filename)
#	if not hit_something:
#		if body.has_method("bullet_hit"):
#			body.bullet_hit(DAMAGE, self.global_transform)
#	hit_something = true
#	self.queue_free()

func _on_timeout():
	var bodies = blast_area.get_overlapping_bodies()
	ap.play("Blast")
	for b in bodies:
		if b.is_in_group("Enemies"):
			if b.has_method("bullet_hit"):
				b.bullet_hit(DAMAGE, self.global_transform)
	yield(ap, "animation_finished")
	self.queue_free()


func _on_Grenade_body_entered(body):
	if not hit_something:
		pass
		# If we don't want it to start until it hits the ground
#		timer.start()
#		hit_something = true
