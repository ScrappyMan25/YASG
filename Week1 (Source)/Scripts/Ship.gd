extends Area2D

var posState
var color
const posCoord: Dictionary = {"Left": 80, "Middle": 240, "Right": 400}
var ship_dead = true

###############################################################

func _ready() -> void:
	ship_dead = true
	position.x = posCoord.Middle
	position.y = 640
	posState = Cyclic.new("Left", "Middle", "Right")
	color = Cyclic.new("Red", "Green", "Blue")
	pass

func _process(_delta: float) -> void:
	if !ship_dead:
		color_input()
		pos_input()
	pass

func color_input():
	if Input.is_action_just_pressed("ui_up"):
		color.stateChange(-1)
		$AnimatedSprite.animate(color.a[2], color.a[1])
	if Input.is_action_just_pressed("ui_down"):
		color.stateChange(1)
		$AnimatedSprite.animate(color.a[0], color.a[1])

	pass


func pos_input():
	if !$AnimationShip.is_playing():
		if Input.is_action_just_pressed("ui_left"):
			posState.stateChange(-1)
			$AnimationShip.pos_animation_Selector(1)

		if Input.is_action_just_pressed("ui_right"):
			posState.stateChange(1)
			$AnimationShip.pos_animation_Selector(-1)
	pass

func compare_Ship_Color(var a)-> bool:
	if a == color.current:
		return true
	else:
		return false
	pass

func _on_Ship_body_entered(_body) -> void:
	if _body.properties.color == null || !compare_Ship_Color(_body.properties.color):
		ship_dead = true
		$AnimatedSprite.play("Warp")
		get_node("CollisionShape2D").set_deferred("disabled", true)
		get_parent().ship_hit()
		pass
	else:
		get_parent().Wormhole_success()
	pass
