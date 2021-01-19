extends VBoxContainer

export var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)
onready var vol_slider := $VolumeSlider
onready var sensitivity_slider := $SensitivitySlider


func _ready():
	var vol = Settings.get_setting("audio","volume")
	var sens = Settings.get_setting("input","mouse_sensitivity")
	
	vol_slider.value = vol
	sensitivity_slider.value = sens * 100


func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value/100 as float))
	Settings.set_setting("audio","volume", value)
#	print("Set vol " + str(value))

func _on_SensitivitySlider_value_changed(value):
	Settings.set_setting("input","mouse_sensitivity", value / 100 as float)
#	print("Set sens " + str(value))
