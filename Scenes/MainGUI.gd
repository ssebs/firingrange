extends Control

export var audio_bus_name := "Master"
onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _on_Start_pressed():
	get_tree().change_scene("res://Map.tscn")


func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value/100 as float))


func _on_CloseContinue_pressed():
	self.queue_free()
