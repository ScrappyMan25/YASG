extends Node

class_name Cyclic

var a = [null, null, null]
var current

func _ready() -> void:
	a = [null, null, null]
	current =  a[1]

func _init(var u, var v, var w) -> void:
	self.a[0] = u
	self.a[1] = v
	self.a[2] = w
	self.current =  a[1]

func find(var val) -> int:
	return a.find(val)

func stateChange(var x):
	match x:
		-1:
			a.push_front(a.pop_back())
			self.current =  a[1]
		1:
			a.push_back(a.pop_front())
			self.current =  a[1]
		0:
			a.push_front(a.pop_back())
			self.current =  a[1]
			a[0].position.y = a[1].position.y - 360

func _free():
	self.queue_free()
