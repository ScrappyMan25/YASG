extends RigidBody2D

class_name wormhole

signal exit_screen
signal game_over
var signal_emitted: bool = false

var properties: Dictionary = {
	"x_index": 0,
	"color": null
}
##########################################################
func _ready() -> void:
	pass

func color_set(var col):
	$AnimatedSprite.play(col)
	$AnimationPlayer.play("Spin")
	self.properties.color = col
	pass

func _process(_delta: float) -> void:
	if position.y > 1000 && !signal_emitted:
		emit_signal("exit_screen")
		signal_emitted = true
	pass

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "self_destruct":
		emit_signal("exit_screen")
	if anim_name == "self_destruct":
		emit_signal("game_over")
	pass
