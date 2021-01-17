extends Area



func _on_Area_body_entered(body):
	body.transform.basis.y += Vector3(0,1000,0)
	body.move_and_slide(body,  Vector3.UP)
