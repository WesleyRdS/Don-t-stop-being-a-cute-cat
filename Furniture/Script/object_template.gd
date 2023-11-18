extends Node2D
class_name Furniture


@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _timer: Timer

var _current_animation = ""



func _on_timer_timeout():
	_animation.play("revert")
	


func _on_area_area_entered(_area)  -> void:
	_animation.play("falling")
	global._object_falling = true
	_current_animation = _animation.current_animation
	_timer.start()


func _on_animation_animation_finished(_anim_name) ->void:
	if _current_animation == "falling":
		print(global._object_falling)
		_current_animation = ""
