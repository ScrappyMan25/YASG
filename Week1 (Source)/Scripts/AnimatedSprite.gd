extends AnimatedSprite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func animate(var _c1, var _c2):
	match _c1:
		"Blue":
			if _c2 == "Green":
				play("GreenToBlue", true)
			elif _c2 == "Red":
				play("BlueToRed")
		"Green":
			if _c2 == "Red":
				play("RedToGreen", true)
			elif _c2 == "Blue":
				play("GreenToBlue")
		"Red":
			if _c2 == "Blue":
				play("BlueToRed", true)
			elif _c2 == "Green":
				play("RedToGreen")
