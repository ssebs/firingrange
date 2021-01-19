extends KinematicBody


onready var nav = get_parent()
onready var ray = $RayCast
onready var dmg_timer = $DmgTimer
onready var ap = $AnimationPlayer

var path = []
var path_node = 0
var speed = 2
var is_in_area = false
export var health = 100

var player

func _ready():
	player = get_tree().get_nodes_in_group("Players")[0]

func _physics_process(delta):
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
	print("Do dmg")
	ap.play("Hit")

func bullet_hit(dmg, body):
	health -= dmg
	if health <= 0:
		ap.play("Die")
		yield(ap, "animation_finished")
		queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group("Players"):
		is_in_area = true
		dmg_timer.start()

func _on_Area_body_exited(body):
	if body.is_in_group("Players"):
		is_in_area = false
		dmg_timer.stop()

func _on_DmgTimer_timeout():
	if is_in_area:
		do_dmg()

func _on_MoveTimer_timeout():
	if player:
		move_to(player.global_transform.origin)
