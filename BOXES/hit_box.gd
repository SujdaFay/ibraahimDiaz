extends Node2D

@onready var raycast2d: RayCast2D = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collition=raycast2d.get_collider()
	if raycast2d.is_colliding():
		if collition and "hit" in collition:
			print(collition)
			collition.hit()
			
