extends "res://Scenes/Guns/Pistols/PistolGeneric.gd"

#_al=7, _as=21, _dmg=20, _fs=1, _vel=80, _hr=1, _vr=2
#func _init().(5, 15, 151, 0.5, 80, 1, 5):
#	pass

func init_vars():
	ammo_left = 5
	ammo_spare = 15
	max_ammo_in_mag = 5
	fire_speed = 0.5
	damage = 151
	bullet_vel = 80
	h_recoil = 2
	v_recoil = 5
