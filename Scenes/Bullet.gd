extends Spatial

export var DAMAGE = 10
export var SPEED = 10
export var GRAVITY = .01
export var TIMEOUT = 20


var g = Vector3.DOWN * GRAVITY
var vel = Vector3.ZERO
var hit_something = false
var timer


func _ready():
	timer = Timer.new()
	self.add_child(timer)
	timer.wait_time = TIMEOUT
	timer.start()
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timeout")
	
	self.set_as_toplevel(true)
	

func _physics_process(delta):
	# Set vel to forward * speed
	vel = -self.global_transform.basis.z.normalized() * SPEED
	# Bullet drop
	vel += g * delta
	self.look_at(self.transform.origin + vel.normalized(), Vector3.UP)
	self.transform.origin += vel * delta

func _on_hit(body):
	if not hit_something:
		if body.has_method("bullet_hit"):
			body.bullet_hit(DAMAGE, self.global_transform)
	hit_something = true
	self.queue_free()

func _on_timeout():
	self.queue_free()
