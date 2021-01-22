extends Area



func _on_Area_body_entered(body):
	body.translate_y(1000)
	body.move_and_slide(body,  Vector3.UP)
