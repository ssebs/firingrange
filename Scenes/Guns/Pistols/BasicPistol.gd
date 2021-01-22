extends "res://Scenes/Guns/Pistols/PistolGeneric.gd"

#_al=7, _as=21, _dmg=20, _fs=1, _vel=80, _hr=1, _vr=2
#func _init().(7, 21, 101, 0.5, 10, 2, 5):
#	pass

func init_vars(): 
	ammo_left = 7
	ammo_spare = 21
	max_ammo_in_mag = 7
	fire_speed = 0.5
	damage = 10
	h_recoil = 2
	v_recoil = 5
