extends AnimationPlayer

var PosCoords: Dictionary = {
	"Left": 80,
	"Middle": 240,
	"Right": 400
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playback_speed = 3

func pos_animation_Selector(var state):
	var ship = get_parent()
	var from = ship.posState.a[state+1]
	var to = ship.posState.current
	queue(from+to)

