extends Control

@export var level1:PackedScene
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	$AudioStreamPlayer2D.play()



	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(level1)
