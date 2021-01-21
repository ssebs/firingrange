extends Spatial

var enemies = []
var max_num_enemies = 5

onready var timer = $Navigation/SpawnTimer
onready var spawns = $Navigation/SpawnPoints
var enemy_type = preload("res://Scenes/Enemies/GenericEnemy.tscn")

func _ready():
	randomize()

func _process(delta):
	for e in enemies:
		if e.is_dead:
			e.queue_free()
			enemies.erase(e)
			break

func spawn_enemies():
	for sl in spawns.get_children():
		if enemies.size() < max_num_enemies:
			var new_enimy = enemy_type.instance()
			new_enimy.global_transform.origin = sl.global_transform.origin + Vector3(lerp(-3,3,randf()), 0, lerp(-3,3,randf()))
			enemies.append(new_enimy)
			sl.get_parent().get_parent().add_child(new_enimy)

func _physics_process(delta):
	spawn_enemies()

func _on_SpawnTimer_timeout():
	if max_num_enemies < 30:
		max_num_enemies += 5
