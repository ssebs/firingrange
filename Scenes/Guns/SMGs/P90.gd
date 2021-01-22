extends "res://Scenes/Guns/SMGs/SMGGeneric.gd"

#_al=30, _as=60, _dmg=15, _fs=2, _vel=80, _hr=1, _vr=2
#func _init().(50,100,25, 2, 80, 2, 3):
#	pass

func init_vars():
	ammo_left = 50
	ammo_spare = 150
	max_ammo_in_mag = 50
	fire_speed = 2
	damage = 25


func reload():
	if ap.is_playing():
		return
	if ammo_spare <= 0 or ammo_left == max_ammo_in_mag:
		return
	
	var ammo_needed = max_ammo_in_mag - ammo_left
	if ammo_spare >= ammo_needed:
		ammo_spare -= ammo_needed
		ammo_left = max_ammo_in_mag
	else:
		ammo_left += ammo_spare
		ammo_spare = 0

	ap.play("P90Reload")
	audio.stream = sound_reload
	audio.play()
	ammo_label.text = "Ammo: " + str(ammo_left) + "/" + str(ammo_spare)
# reload
