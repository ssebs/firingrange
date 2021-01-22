extends Control

export var audio_bus_name := "Master"
onready var _bus := AudioServer.get_bus_index(audio_bus_name)
onready var vol_slider := $Panel/SettingsView/VolumeSlider
onready var sensitivity_slider := $Panel/SettingsView/SensitivitySlider

# Load settings
func _ready():
	var vol = Settings.get_setting("audio","volume")
	var sens = Settings.get_setting("input","mouse_sensitivity")
	
	AudioServer.set_bus_volume_db(_bus, linear2db(vol as float))
	vol_slider.value = vol
	sensitivity_slider.value = sens * 100
	

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Maps/Default/Map.tscn")


func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value/100 as float))
	Settings.set_setting("audio","volume", value)


func _on_CloseContinue_pressed():
	self.queue_free()


func _on_SensitivitySlider_value_changed(value):
	Settings.set_setting("input","mouse_sensitivity", value / 100 as float)

