extends RigidBody

var health = 100

func bullet_hit(dmg, body):
	health -= dmg
	if health <= 0:
		self.queue_free()

func bullet_hit_pass(dmg, body):
	health -= dmg
	if health <= 0:
		self.queue_free()
