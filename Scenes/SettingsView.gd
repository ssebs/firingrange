extends VBoxContainer

export var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)
onready var vol_slider := $VolumeSlider
onready var sensitivity_slider := $SensitivitySlider
onready var kbc := $KeyBindContainer
onready var btn_script := preload("res://KeyButtonSet.gd")

var settings
var keybinds
var buttons = {}

func _ready():
	var vol = Settings.get_setting("audio","volume")
	var sens = Settings.get_setting("input","mouse_sensitivity")
	
	vol_slider.value = vol
	sensitivity_slider.value = sens * 100
	
	Settings.load_settings()
	
	settings = Settings._settings.duplicate()
	keybinds = Settings._settings["input"].duplicate()
	
	load_keybinds()


func load_keybinds():
	for key in keybinds.keys():
		if "k_" in key:
			var hbx = HBoxContainer.new()
			var lbl = Label.new()
			var btn = Button.new()
			
			hbx.set_h_size_flags(Control.SIZE_EXPAND_FILL)
			lbl.set_h_size_flags(Control.SIZE_EXPAND_FILL)
			btn.set_h_size_flags(Control.SIZE_EXPAND_FILL)
			
			lbl.text = key
			var btn_val = keybinds[key]
			btn.text = OS.get_scancode_string(btn_val)
			btn.set_script(btn_script)
			btn.key = key
			btn.val = btn_val
			btn.menu = self
			btn.toggle_mode = true
			btn.focus_mode = Control.FOCUS_NONE
			
			hbx.add_child(lbl)
			hbx.add_child(btn)
			kbc.add_child(hbx)
			buttons[key] = btn
	# end for

func change_keybind(key, val):
	keybinds[key] = val
	for k in keybinds.keys():
		if k != key and val != null and keybinds[k] == val:
			keybinds[k] = null
			buttons[k].val = null
			buttons[k].text = "Unnasigned"
	settings["input"] = keybinds.duplicate()
	Settings.set_settings(settings)
	Settings.load_settings()

func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value/100 as float))
	Settings.set_setting("audio","volume", value)
#	print("Set vol " + str(value))

func _on_SensitivitySlider_value_changed(value):
	Settings.set_setting("input","mouse_sensitivity", value / 100 as float)
#	print("Set sens " + str(value))
