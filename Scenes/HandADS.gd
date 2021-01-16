extends Spatial

const ADS_LERP = 20

export var default_pos: Vector3
export var ads_pos: Vector3
export var cam_path: NodePath
export var crosshair_path: NodePath

var cam: Camera
var crosshair: TextureRect
var fov = {"Default": 70, "ADS": 55}

func _ready():
	cam = get_node(cam_path)
	crosshair = get_node(crosshair_path)

func _process(delta):
	if Input.is_action_pressed("aim"):
		self.transform.origin = self.transform.origin.linear_interpolate(ads_pos, ADS_LERP * delta)
		cam.fov =  lerp(cam.fov, fov["ADS"], ADS_LERP * delta)
		crosshair.hide()
	else:
		self.transform.origin = self.transform.origin.linear_interpolate(default_pos, ADS_LERP * delta)
		cam.fov =  lerp(cam.fov, fov["Default"], ADS_LERP * delta)
		crosshair.show()
# _process
