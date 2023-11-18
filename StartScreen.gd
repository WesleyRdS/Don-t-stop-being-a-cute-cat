extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_mouse_entered():
	$Animation.play("Play")


func _on_texture_button_mouse_exited():
	$Animation.play("RESET")


func _on_texture_button_pressed():
	$Animation.play("Start")
	get_tree().change_scene_to_file("res://Management/Scene/game_level.tscn")
