extends Node

var health:=10
var damage:=2
var hitState:=false
var death:=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func healthDec()->void:
	if health >0:
		health=health-1
	else:
		pass
		#death=true

func healthInc()->void:
	if health <10:
		health=health+2
