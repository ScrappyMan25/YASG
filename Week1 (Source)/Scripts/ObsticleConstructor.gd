extends Node2D

export var speed: int = 100
export var counter: int = 0
export var spawn_limit: int = 3
export var y_pos = -100

var Obsticle_Set = preload("res://obsticle.tscn")
var o1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_obsticle()
	print(str(get_child_count()))
	print(str(get_children()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_child_count() != 0:
		for i in get_children():
			i.position.y += speed * _delta
			if i.position.y > 1000:
				i.respawn()
				i.position.y = y_pos
				speed += 50
	pass

func add_obsticle() -> void:
	o1 = Obsticle_Set.instance()
	o1.position.y = y_pos
	o1.speed = speed
	add_child(o1)
	pass
