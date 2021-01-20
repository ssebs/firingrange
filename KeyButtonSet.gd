extends Button

var key
var val
var menu

var waiting_input = false

func _input(event):
	if waiting_input:
		if event is InputEventKey:
			val = event.scancode
			text = OS.get_scancode_string(val)
			menu.change_keybind(key, val)
			pressed = false
			waiting_input = false
		if event is InputEventMouseButton:
			if val:
				text = OS.get_scancode_string(val)
			else:
				text = "Unassigned"
			pressed = false
			waiting_input = false


func _toggled(button_pressed):
	if button_pressed:
		waiting_input = true
		set_text("Press any key")
