extends Spatial




func _on_Area_body_entered(body):
	if body.is_in_group("Players") or body.is_in_group("Bullets"):
		get_tree().change_scene("res://Scenes/Maps/TestMap/TestMap.tscn")
