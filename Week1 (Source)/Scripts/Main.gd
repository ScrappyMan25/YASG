extends Node

export (PackedScene) var Obsticle
export (PackedScene) var Ship
var o
var ship
var counter: int = 0
var High: int = 0
var Last: int = 0

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

func _ready() -> void:
	VisualServer.set_default_clear_color(Color(0,0,0,1.0))
	ship = Ship.instance()
	ship.ship_dead = true
	ship.get_node("AnimatedSprite").play("Warp")
	ship.get_node("CollisionShape2D").set_deferred("disabled", true)
	add_child(ship)
	$ColorBand.control= !ship.ship_dead
	$Node2D/Button.grab_focus()
	pass

func _theStart():
	$Node2D/Button.set_deferred("disabled", true)
	$Music.play()
	counter = 0
	$Score.text = str(counter)
	ship.ship_dead = false
	ship.get_node("CollisionShape2D").set_deferred("disabled", false)
	ship.get_node("AnimatedSprite").play("Green")
	ship.color = Cyclic.new("Red", "Green", "Blue")
	$ColorBand.control= !ship.ship_dead
	$ColorBand.Band = Cyclic.new("red", "green", "blue")
	o = Obsticle.instance()
	o.position = Vector2(0,0)
	add_child(o)
	pass

func _process(_delta: float) -> void:
	#Scrolling BG
	$BG/star_bg1.position.y -= 100 * _delta
	$BG/star_bg2.position.y -= 100 * _delta
	if $BG/star_bg1.position.y < -775/2:
		$BG/star_bg1.position.y = $BG/star_bg2.position.y + 775
	if $BG/star_bg2.position.y < -775/2:
		$BG/star_bg2.position.y = $BG/star_bg1.position.y + 775
	pass

func ship_hit():
	$Music.stop()
	$GameOver.play()
	o.end_obsticles()
	$AnimationPlayer.play("move_menu_in")
	$ColorBand.get_node("AnimationPlayer").play("blue_up")
	Last = counter
	if Last > High:
		High = Last
	$Node2D/High_score.text = "HIGH: " + str(High)
	$Node2D/Last_score.text = "LAST: " + str(Last)
	ship.ship_dead = true
	$ColorBand.control= !ship.ship_dead
	
	$Node2D/Button.set_deferred("disabled", false)
	pass

func Wormhole_success():
	o.obsticle_hit()
	counter += 1
	$Score.text = str(counter)	
	pass

func _on_Button_pressed() -> void:
	$AnimationPlayer.play("move_menu_out")
	pass

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "move_menu_out":
		_theStart()
	pass
