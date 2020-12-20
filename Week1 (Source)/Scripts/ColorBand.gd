extends Node2D
var control = false
var Band

func _ready() -> void:
	Band = Cyclic.new("red", "green", "blue")
	$AnimationPlayer.playback_speed = 3
	control=false
	pass

func _process(_delta: float) -> void:
	if control:
		if Input.is_action_just_pressed("ui_up"):
			Band.stateChange(-1)
			$AnimationPlayer.play(Band.a[2] + "_" + "up")
		if Input.is_action_just_pressed("ui_down"):
			Band.stateChange(1)
			$AnimationPlayer.play(Band.a[0] + "_" + "down")
	pass
