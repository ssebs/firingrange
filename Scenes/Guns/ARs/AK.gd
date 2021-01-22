extends "res://Scenes/Guns/ARs/ARGeneric.gd"

##_al=30, _as=60, _dmg=20, _fs=1, _vel=80, _hr=1, _vr=2
#func _init().(30,60,34, 0.75, 80, 2, 3):
#	pass

func init_vars():
	ammo_left = 35
	ammo_spare = 105
	max_ammo_in_mag = 35
	fire_speed = 0.75
	damage = 35
	bullet_vel = 80
	h_recoil = 2
	v_recoil = 3
