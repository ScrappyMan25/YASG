extends Node2D

class_name obsticle

var speed: int = 200
var y_pos: int = -100
var rng = RandomNumberGenerator.new()
var x_indices = [
	[80, 240, 400],
	[80, 400, 240],
	[240, 80, 400],
	[240, 400, 80],
	[400, 80, 240],
	[400, 240, 80]
]
var col = [
	"Red",
	"Green",
	"Blue"
]

#######################################################

func random_selector(var x)-> int:
	rng.randomize()
	return rng.randi_range(0, x)
	pass

func _init()->void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn()
	pass

func spawn():
	var x_index: Array = x_indices[random_selector(5)] #xindex is now an array with 80, 240 , 400 rand.
	var color = col[random_selector(2)]

	$Asteroid.linear_velocity = Vector2(0,speed)
	$Asteroid2.linear_velocity = Vector2(0,speed)
	$Wormhole.linear_velocity = Vector2(0,speed)
	
	$Asteroid.position = Vector2(x_index[0], -100)
	$Asteroid2.position = Vector2(x_index[1], -100)
	$Wormhole.position = Vector2(x_index[2], -100)
	
	$Asteroid.properties.x_index = x_index[0]
	$Asteroid2.properties.x_index = x_index[1]
	$Wormhole.properties.x_index = x_index[2] 
	
	$Wormhole.properties.color = color 
	$Wormhole.color_set(color)
	$Wormhole.signal_emitted = false
	pass

func _process(_delta: float) -> void:
	pass

func success_wormhole():
	for i in get_children():
		i.get_node("AnimationPlayer").play("self_destruct")
		i.get_node("CollisionShape2D").set_deferred("disabled", true)
		i.set_sleeping(true)
	pass

func game_over():
	for i in get_children():
		i.set_sleeping(true)
		i.get_node("AnimationPlayer").play("game_over")
		i.get_node("CollisionShape2D").set_deferred("disabled", true)
	pass

func _on_Wormhole_exit_screen() -> void:
	self.queue_free()
	get_parent().exited()
	pass

func _on_Wormhole_game_over() -> void:
	self.queue_free()
	pass
