extends StaticBody

onready var vp = $FloatingTextVP
onready var vpl = $FloatingTextVP/Label
onready var vpq = $VPQuad

export var cost = 1000

func _ready():
	
	vpq.material_override.albedo_texture = vp.get_texture()
	vpl.text = "Buy Ammo ($" + str(cost) + ")"

func buy():
	return {"type":"AMMO", "cost": cost}
