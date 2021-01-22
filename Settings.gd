extends Node

const SAVE_PATH = "user://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"audio": {
		"volume": 70
	},
	"input": {
		"mouse_sensitivity": 0.07,
		"k_inspect": 73,
		"k_sprint": 16777237,
		"k_interact": 70
	}
}

func _ready():
	var f = File.new()
	if not f.file_exists(SAVE_PATH):
		save_settings()
	load_settings()

func set_setting(category,key, val):
	_settings[category][key] = val
	save_settings()


func get_setting(category,key):
#	print(_settings[category][key])
	return _settings[category][key]

func set_settings(settings):
	_settings = settings.duplicate()
	print(_settings)
	save_settings()
	
func save_settings():
	for s in _settings.keys():
		for k in _settings[s].keys():
			_config_file.set_value(s, k, _settings[s][k])
#	print("saved settings")
	_config_file.save(SAVE_PATH)

func load_settings():
	var err =  _config_file.load(SAVE_PATH)
	if err != OK:
		print("Error loading settings from " + SAVE_PATH + ". Error: " + str(err))
		return

	for s in _settings.keys():
		for k in _settings[s].keys():
			_settings[s][k] = _config_file.get_value(s, k, 0)
#	print(_settings)
	set_keybinds()
# load_settings

func set_keybinds():
	for k in _settings["input"].keys():
		if "k_" in k:
			var val = _settings["input"][k]
			var actionlist = InputMap.get_action_list(k)
			if !actionlist.empty():
				InputMap.action_erase_event(k, actionlist[0])
			var new_key = InputEventKey.new()
			new_key.set_scancode(val)
			InputMap.action_add_event(k, new_key)
