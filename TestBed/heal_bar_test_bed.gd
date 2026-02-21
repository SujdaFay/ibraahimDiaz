extends Node2D

var health:int=5
@onready var health_bar: ProgressBar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value=health # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_add_button_down() -> void:
	if health<10:
		health_bar.value+=1


func _on_sub_button_down() -> void:
	if health>0:
		health_bar.value-=1
