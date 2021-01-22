extends KinematicBody


onready var nav = get_parent()
onready var ray = $RayCast
onready var dmg_timer = $DmgTimer
onready var ap = $AnimationPlayer

var path = []
var path_node = 0
var speed = 5
var damage = 10
var is_in_area = false
var is_dead = false
var target_body

export var health = 100

var player

func _ready():
	player = get_tree().get_nodes_in_group("Players")[0]

func _physics_process(delta):
	if health > 0:
		if path_node < path.size():
			var dir = (path[path_node] - global_transform.origin)
			if dir.length() < 1:
				path_node += 1
			else:
				move_and_slide(dir.normalized() * speed, Vector3.UP)
		look_at(player.transform.origin, Vector3.UP)

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func do_dmg():
	ap.play("Hit")
	if target_body.has_method("take_dmg"):
		target_body.take_dmg(damage, self.global_transform)

func bullet_hit(dmg, body):
	print("Take dmg")
	health -= dmg
	if health <= 0:
		die()

func die():
	ap.play("Die")
	player.money += 100
	yield(ap, "animation_finished")
	is_dead = true
	queue_free()

func _on_Area_body_entered(body):
	if health > 0:
		if body.is_in_group("Players"):
			is_in_area = true
			dmg_timer.start()
			target_body = body

func _on_Area_body_exited(body):
	if health > 0:
		if body.is_in_group("Players"):
			is_in_area = false
			dmg_timer.stop()
			target_body = null

func _on_DmgTimer_timeout():
	if health > 0:
		if is_in_area:
			do_dmg()

func _on_MoveTimer_timeout():
	if health > 0:
		if player:
			move_to(player.global_transform.origin)
