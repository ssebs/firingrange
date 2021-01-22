extends "res://Scenes/Guns/SMGs/SMGGeneric.gd"

#_al=30, _as=60, _dmg=15, _fs=2, _vel=80, _hr=1, _vr=2
#func _init().(25,50,45, 1.5, 80, 3, 5):
#	pass

func init_vars():
	ammo_left = 25
	ammo_spare = 75
	max_ammo_in_mag = 25
	fire_speed = 1.5
	damage = 45
	bullet_vel = 80
	h_recoil = 3
	v_recoil = 5
